#!/bin/sh -e
echo "This is my shitty arch install script, caps sensisitive so pls follow the stuff"

timedatectl set-ntp true && echo "time set with sucess" #Sets time on ISO

echo "If on GPT, say 1; if MBR say 0" #Ask for GPT and store
read GPT

echo -n "What disk do you want to use? [/dev/sdx]"
read disk

#gonna start the actual partitioning
echo "Make new partition table?[Y/n]"
read part_new

if [[ $part_new == 'n' ]]
then
	echo "Not remaking partition table"
else
	if [[ $GPT == 0 ]]
	then
		echo "Making MBR partition table"
	else
		echo "Making a new GPT table"
	fi
fi

if [[ $GPT == '0' ]]
then
	echo "Skipping efi questions"
else
	{
	echo "Make new efi partition? [Y/n]"
	read efi_new
	}

	if [[ efi_new == 'n' ]]
	then
		echo "What's your efi partition?[/dev/disk1]"
		read efi_path
	fi
fi




