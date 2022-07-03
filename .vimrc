set nocompatible

call plug#begin('~/.vim/plugged')
    "-------------------=== Code/Project navigation ===-------------
    Plug 'preservim/nerdtree'  " Project and file navigation
    Plug 'majutsushi/tagbar'    " Class/module browser
    Plug 'mbbill/undotree'		" Undo tree 

    "-------------------=== Other ===-------------------------------
    Plug 'bling/vim-airline'                  " Lean & mean status/tabline for vim
    Plug 'vim-airline/vim-airline-themes'     " Themes for airline
    Plug 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plug 'pangloss/vim-javascript'
    " Plug 'chriskempson/base16-vim', {'do': 'git checkout dict_fix'}
    Plug 'danielwe/base16-vim' " use unofficial fork until major issue is fixed
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'

    "-------------------=== Languages support ===-------------------
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/syntastic'     " Syntax checking plugin for Vim

    "-------------------=== Python  ===-----------------------------
    Plug 'python-mode/python-mode'  " Python mode (docs, refactor, lints...)
call plug#end()                           " required

"=====================================================
"" General settings
"=====================================================
set t_Co=256                                " set 256 colors
set background=dark
colorscheme base16-tomorrow-night

set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code

autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

" set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8	                            " utf-8 by default

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

set clipboard=unnamedplus                       " use system clipboard

set secure                                  " prohibit .vimrc files to execute shell, create files, etc...

set ignorecase                              " ignore case when searching
set smartcase

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
" autocmd BufEnter *.py :call tagbar#autoopen(0)
" autocmd BufWinLeave *.py :TagbarClose
nmap <F7> :TagbarOpenAutoClose<CR>
nmap <F8> :Tagbar<CR>

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap <F2> :NERDTreeToggle <CR>
let NERDTreeQuitOnOpen=0
map <C-n> :NERDTreeToggle<CR>

"=====================================================
"" Undotree settings
"=====================================================
nnoremap <F5> :UndotreeToggle<cr>

"=====================================================
"" Python settings
"=====================================================

" python executables for different plugins
let g:pymode_lint_ignore=["E501"]

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_key='K'

" lints
let g:pymode_lint=1

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']

" YouCompleteMe
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>


"=====================================================
"" Other settings
"=====================================================
" keep all undos files in the same place
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Automatically close function preview windows
autocmd CompleteDone * pclose
 
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Quit insert mode with jj
inoremap jj <Esc>

" fix base16-vim green line
set termguicolors
