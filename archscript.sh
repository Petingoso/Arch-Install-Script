#!/bin/sh -e
echo "This is my shitty arch install script, caps sensisitive so pls follow the stuff"

timedatectl set-ntp true && echo "time set with sucess" #Sets time on ISO

echo "If on GPT, say 1; if MBR say 0" #Ask for GPT and store
read GPT
echo "$GPT"

echo "What disk do you want to use?"
read disk


if [$GPT=='0']
then
	echo"Skipping efi"
else
	{
	echo"Make new efi partition? [y/n]"
	read efi_new
	}

	if [efi_new == 'n']
	then
		echo "What's your efi partition?[/dev/disk1]"
		read efi_path
	fi
fi

