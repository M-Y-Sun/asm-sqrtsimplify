#!/bin/bash

if [ $(uname -m) == "arm32" ]; then
    printf "[   \033[1;32mOK\033[0m   ] system architecture matches program architecture\nprogram can be run natively, baremetal\n"
else
    printf "[ \033[1;31mFAILED\033[0m ] system architecture does not match program architecture\nvirtual machine or emulator is required\n"
fi

