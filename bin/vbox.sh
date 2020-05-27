#!/usr/bin/env bash

ssh_box() {
    echo -e "\e[34mSpawning SSH...\n\e[0m"
    ssh -D 8888 hugo@127.0.0.1 -p 2222
}

close_box() {
    echo
    read -p $'\e[31mPoweroff box (y/n)? \e[0m' -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        vboxmanage controlvm "ArchPen" poweroff
     fi 
}

if ! [[ $(vboxmanage list runningvms) ]]; then
    echo -e "\e[32mTurning on ArchPen...\e[0m"
    vboxmanage startvm "ArchPen" --type headless
    sleep 10
fi    
ssh_box
close_box 
