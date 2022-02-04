#!/bin/sh -e
echo "This is my shitty arch install script"

timedatectl set-ntp true && echo "time set with sucess"#sets time

echo "If on GPT, say 1; if MBR say 0"
read GPT
echo "$GPT"

