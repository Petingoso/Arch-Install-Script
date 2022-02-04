#!/bin/sh -e
echo "This is my shitty arch install script, caps sensisitive so pls follow the stuff"

timedatectl set-ntp true && echo "Time was set with sucess" #Sets time on ISO

echo -n "If on GPT, say 1; if MBR say 0: " #Ask for GPT and store
read GPT

echo -n "What disk do you want to use? [/dev/sdx]: "
read disk

#gonna start the actual partitioning
echo -n "Make new partition table? [Y/n]: "
read part_new

if [[ $part_new == 'n' ]]
then
	echo "Not remaking partition table"
else
	if [[ $GPT == 0 ]]
	then
		echo "Making MBR partition table"
		parted $disk mklabel msdos

	else
		echo "Making a new GPT table"
		parted $disk mklabel gpt
	fi
fi

if [[ $GPT == '0' ]]
then
	echo "Skipping efi questions"
else
	{
	echo -n "Make new efi partition? [Y/n]: "
	read efi_new
	efi_path="${disk}1"
	echo -n "What's the size?: "
	read efi_size
	parted $disk mkpart "EFI_ARCH" fat32 1M +$efi_size

	}

	if [[ efi_new == 'n' ]]
	then
		echo -n "What's your efi partition?[/dev/disk1]: "
		read efi_path
	fi
fi

echo -n "What's the root size?: "
read root_size

echo -n "Root filesystem? [ext4]: "
read root_fs

if [[ $GPT == '1' ]]
then
	parted mkpart "ARCH_ROOT" $root_fs $efi_size +$root_size
	echo "Made root with $root_fs with $root_size"
else
	parted mkpart "ARCH_ROOT" $root_fs 1M +$root_size
	echo "Made root with $root_fs with $root_size"

echo "Make swap? [Y/n]: "
read swap_yes

if [[ $swap_yes == 'n' ]]
then
	echo -n "Skipping Swap"
else
	echo -n "Swap size?: "
	read swap_size
	parted "SWAP" linux-swap +$root_size $swap_size
echo "Swap Done"
