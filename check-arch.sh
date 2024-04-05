#!/bin/bash

if [ "$(uname -m | grep -c "armv")" -eq 1 ]; then
    printf "[   \033[1;32mOK\033[0m   ] system architecture matches program architecture\n[  \033[1;37mINFO\033[0m  ] program can be run natively, baremetal\n"
else
    printf "[ \033[1;31mFAILED\033[0m ] system architecture does not match program architecture\n[  \033[1;37mINFO\033[0m  ] virtual machine or emulator is required\n"
fi

