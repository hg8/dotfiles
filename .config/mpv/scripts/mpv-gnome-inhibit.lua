--[[

Prevent the screen from blanking while a video is playing.

This script is a workaround for the GNOME+Wayland issue documented in the
[Disabling Screensaver] section of the mpv manual, and depends on
gnome-session-inhibit (usually provided by the gnome-session package) to set up
the inhibitors.


# CAVEATS

This is not (yet?) a foolproof solution.

At this time GNOME's implementation of the Inhibit protocol does not support the
SimluateUserActivity method:

    dbus-send --print-reply --session \
      --dest=org.gnome.ScreenSaver --type=method_call \
      /org/gnome/ScreenSaver org.gnome.ScreenSaver.SimulateUserActivity

So there seems to be no way to "poke" the system with a heartbeat to extend to
idle timeout for a bit and prevent blanking.

This means that inhibitors have to be installed, then removed when mpv exits.

The current implementation handles this via another application, which should
always be available on GNOME+Wayland desktops (because provided by gnome-session
itself): gnome-session-inhibit.

Executing gnome-session-inhibit to handle this is not ideal because if mpv does
not exit cleanly, gnome-session-inhibit is not necessarily killed (it can get
orphaned, and gets adopted by the init process), leaving the inhibitors intact
with no easy way for the user to figure it out.

Ideally this script should open a DBus session directly to handle the
inhibitors, as they would be removed if the DBus session gets disconnected (cf.
[Inhibit's documentation][Inhibit]):

> Applications should invoke [Inhibit ()] when they begin an operation that
> should not be interrupted [...] When the application completes the operation
> it should call Uninhibit() or disconnect from the session bus.

This is how [other applications] do it.

But really, the only secure way to handle this would be with a heartbeat to
regularly reset the idle timer, i.e. what SimulateUserActivity is supposed to
provide. Especially for a core security feature such as screen locking (cf.
xscreensaver author's [rant][jwz]).


# Work notes

## Detecting readiness

If inhibitor:remove is called too quickly after inhibitor:install, mpv sometimes
fails to remove the inhibitor. With the current implementation (where a single
"cookie" is used) it can lead to two inhibitors being installed at once, and the
first inhibitor only gets removed when closing mpv.

This cannot be reproduced by just calling inhibitor:{install,remove} one after
the other in code, but registering them on separate events sometimes triggers
the issue, something like:

    mp.observe_property('foo', nil, inhibitor:install)
    mp.observe_property('bar', nil, inhibitor:remove)

In particular, this happens during the script's "initialization": when
registering a property observer with mp.observe_property, the function is always
triggered once immediately. Per the [documentation][Lua API]:

> You always get an initial change notification. This is meant to initialize the
> user's state to the current value of the property.

I presume that there something funny going on when mp.command_native_async and
mp.abort_async_command get called in the same "tick" of the event loop, maybe
the cookie isn't properly registered and aborting then fails.

Anyway, at first this problem seemed to only occur during initialization, and I
attempted to solve the issue by preventing the inhibitor from being installed
until the initialization is complete.

In order to delay the inhibitor until then, an observer is registered on a dummy
property 'plugin-initialized', and the registration is done after all the other
observers.

Technically the documentation doesn't say that registration order is respected
for property observers (though it is mentioned that it is for event observers
registered on the same event) but it seems to work reliably.

However it didn't work anymore after a rewrite of the inhibitor handler, as a
single mpv event could trigger again several internal triggers in a row. I might
fix this later, but the underlying issue is still that mp.abort_async_command
doesn't work as advertised and I wanted to have that fixed in isolation.

The next attempt to solve the issue was to add a small delay before calling
mp.abort_async_command. It seemed to work reliably with

    os.execute('sleep 0.01')

but I didn't like calling an extra external command, so instead I opted for
using an mpv timeout that calls the abort function.

This could have replaced the first "dummy event" fix, but I actually like being
able to easily ensure that the state has been fully initialized before checking
the trigger conditions so I'm keeping it around.


## Orphaned inhibitors

When mpv does not terminate gracefully, e.g. when killed with `kill -9 <pid>`,
installed inhibitor don't get removed, which can be difficult to figure out for
the user.

One technique that solves the issue is to use gnome-session-inhibit with a
command that is able to check whether mpv is running, and exit when it isn't
anymore.

tail has a --pid option that can do just that, and it just takes removing in
mp.command_native_async the '--inhibit-only' argument and specifying the
subcommand

    'tail', '--pid', tostring(utils.getpid()), '-f', '/dev/null'

Alternatively, something similar can be achieved by using a shell command to
poll on the result of

    kill -0 <mpv-pid>

and exit if it fails.

But if was that easy, you wouldn't be reading that. So what's the problem?

It turns out that when gnome-session-inhibit gets killed, including by mpv when
requested with mp.abort_async_command, gnome-session-inhibit doesn't kill its
child process, and becomes "<defunct>". So now the problem just propagated to
tail, and even worse, this makes mpv unable to gracefully exit anymore: it
hangs waiting for gnome-session-inhibit to exit, which in turn is waiting for
tail to exit, which won't happen until mpv exits because of the --pid option.

This cure is unfortunately worse than the desease.

Another attempt was made using an extra check to determine whether the
subcommand's parent process (supposedly gnome-session-inhibit) became defunct:

    ppid=$PPID
    ps -o stat= --pid $ppid | grep Z

Note that the initial PPID has to be stored into another variable because PPID
is automatically updated when the process gets orphaned.

The issue is that mpv still hangs on normal shutdowns, and the polling interval
has to be short enough to not become annoying. Damn :(


## Debugging

Use mpv's `--msg-level` CLI option to increase the log level for messages from
this script, e.g.:

    mpv --msg-level=gnome_inhibit=debug --no-msg-color ...

Use `gnome-session-inhibit -l` to list the active inhibitors. When this script
is enabled and a video is playing, you should see

    mpv: video-playing (idle)


# TODO

- Allow configuring
  - Whether to inhibit at all when only audio is playing
  - Whether to inhibit idle (screen blanking) when only audio is playing
- Fix inhibitors not removed when mpv does not terminate gracefully, e.g. with
  `kill -9 <pid>`, either by having a wrapper around gnome-session-inhibit
  checking the parent PID (see https://stackoverflow.com/a/2035683), or by
  interfacing with dbus to open a session that gets disconnected if mpv
  terminates uncleanly (hopefully), or ...


[Disabling Screensaver]: https://mpv.io/manual/master/#disabling-screensaver
[Inhibit]: https://people.gnome.org/~mccann/gnome-session/docs/gnome-session.html#org.gnome.SessionManager.Inhibit
[jwz]: https://www.jwz.org/blog/2021/01/i-told-you-so-2021-edition/
[other applications]: https://unix.stackexchange.com/a/438335
[Lua API]: https://github.com/mpv-player/mpv/blob/master/DOCS/man/lua.rst

]]


local mp = require 'mp'
local log = mp.msg


-- -----------------------------------------------------------------------------
-- The hands
-- -----------------------------------------------------------------------------

local inhibitor = {}

function inhibitor.new()
    -- Opaque token for the async gnome-session-inhibit token
    local cookie = nil

    local handle = {}

    function handle.remove(self)
        if not cookie then return end

        -- The abort call can actually silently fail to abort the command under
        -- some unknown conditions, and delaying it a tiny bit seems to solve
        -- the issue, cf. work notes.
        -- This means that several inhibitors can be installed at the same time
        -- for a fraction of a second, hopefully nobody will notice ;) ;)
        local c = cookie
        mp.add_timeout(0.01, function()
            mp.abort_async_command(c)
        end)
        cookie = nil
    end

    function handle.install(self, level, reason)
        if cookie then return end

        cookie = mp.command_native_async(
            {
                name = 'subprocess',
                args = {
                    'gnome-session-inhibit',
                    '--inhibit', level,
                    '--app-id', 'mpv',
                    '--reason', reason,
                    '--inhibit-only',
                },

                -- `playback_only = true` does not kill the command when
                -- playback is paused (i.e. "pause" is still "playback == true")
                -- but also kills it immediately the first time. So we need to
                -- handle the paused state ourselves.
                playback_only = false,

                -- If not captured, mpv will just forward everything to stdout
                -- and stderr. Setting capture_stdXXX with capture_size = 0 will
                -- ensure that the command's output is discarded.
                capture_stdout = true,
                capture_stderr = true,
                capture_size = 0,
            },

            -- The cookie could be cleaned up here, but it might prevent new
            -- handlers from being installed under some race conditions. It's
            -- easier to clean it in the remove function than to do it right.
            -- Note: This parameter of command_native_async should be optional
            -- according to the doc, but I get an error if I don't provide a
            -- function: attempt to call local 'cb' (a nil value)
            function() end
        )
    end

    return handle
end


-- -----------------------------------------------------------------------------
-- Teh Brainz
-- -----------------------------------------------------------------------------

local state = {

    -- We want at most a single inhibitor to be installed for each mpv instance.
    inhibitor = inhibitor.new(),

    -- Events cache to allow complex trigger conditions. No, not that complex...
    events = {},

    -- A list of rules with associated action that gets executed when the result
    -- of the rule changes due to an event fired by mpv. The result of the rule
    -- is passed to the action so it doesn't have to compute it again.
    triggers = {

        state = {
            rule = function(events)
                if not events['plugin-initialized'] then return false end
                if not events['stop-screensaver'] then return false end

                if events['mute'] and not events['vo-configured'] then return false end
                -- Might not work reliably depending on the VO and windowing
                -- system (cf. mpv manual)
                if events['window-minimized'] and events['vo-configured'] then return false end

                -- mpv's --keep-open option triggers a 'pause' event at the end
                -- of the file, but --idle doesn't, and instead triggers an
                -- 'idle-active' event.
                return not events['pause'] and not events['idle-active']
            end,

            action = function(state, evt, enabled)
                if enabled then
                    local level = state.triggers.level.rule(state.events)
                    local reason = (state.events['vo-configured'] and 'video' or 'audio')..' playing'
                    state.inhibitor:install(level, reason)
                    log.verbose('inhibit on ('..evt..')')
                else
                    state.inhibitor:remove()
                    log.verbose('inhibit off ('..evt..')')
                end
            end,
        },

        level = {
            rule = function(events)
                if not events['plugin-initialized'] then return end

                -- If mpv is playing a video, we prevent the screen from
                -- blanking. If it is only playing audio, the screen can blank
                -- and we only prevent the computer from going to sleep.
                -- Note: when a video is started, mpv fires vo-configured with
                -- false, and then shortly after again with true when the
                -- relevant subsystems get initialized.
                return events['vo-configured'] and 'suspend:idle' or 'suspend'
            end,

            action = function(state, evt, level)
                local reason = (state.events['vo-configured'] and 'video' or 'audio')..' playing'

                -- We only need to refresh the inhibitor if it's already
                -- installed, otherwise we can just wait for the next
                -- installation.
                if state.triggers.state.rule(state.events) then
                    state.inhibitor:remove()
                    state.inhibitor:install(level, reason)
                    log.verbose('inhibit upd ('..evt..')')
                end
            end,
        },
    },
}

-- Update the internal state from an mpv event and check the triggers.
function state.update(self, evt, val)
    local snap = {}
    for name, trigger in pairs(self.triggers) do
        snap[name] = {}
        snap[name].old = trigger.rule(self.events)
    end

    self.events[evt] = val

    for name, trigger in pairs(self.triggers) do
        snap[name].new = trigger.rule(self.events)
        snap[name].changed = snap[name].new ~= snap[name].old
    end

    for name, status in pairs(snap) do
        log.debug('state update:', evt, '=', val, '/', name, ':', status.old, '->', status.new)
        if status.changed then
            self.triggers[name].action(self, evt..':'..name, status.new)
        end
    end
end


-- -----------------------------------------------------------------------------
-- Wire everything together
-- -----------------------------------------------------------------------------

-- I like my instance method on state, leave me alone ☹
local function event_update(evt, val)
    state:update(evt, val)
end

-- Handle the dummy 'plugin-initialized' event, indicating that all the other
-- events should have been fired once already and the state is initialized.
local function event_ready(evt)
    -- The dummy event gets fired regularly for no apparent reason. It wouldn't
    -- harm to keep the observer around, but I prefer my debug logs clean.
    mp.unobserve_property(event_ready)
    state:update(evt, true)
end


mp.observe_property('stop-screensaver', 'bool', event_update)
mp.observe_property('pause', 'bool', event_update)
mp.observe_property('idle-active', 'bool', event_update)
mp.observe_property('vo-configured', 'bool', event_update)
mp.observe_property('window-minimized', 'bool', event_update)
mp.observe_property('mute', 'bool', event_update)

-- Must be registered after all the other property observers, cf. work notes
mp.observe_property('plugin-initialized', nil, event_ready)

log.info(
    'GNOME+Wayland idle inhibit workaround enabled.',
    'You can ignore the warning from the [vo/gpu/wayland] component.'
)