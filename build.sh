#!/bin/bash

# Build Script for Y301-A2

# set toolchain, clean, then make.
export ARCH=arm
export SUBARCH=arm
export CCOMPILER=$HOME/android/prebuilt/linux-x86/toolchain/arm-eabi-4.6/bin/arm-eabi-

rm -r out
make clean
make mrproper

echo    "##########################"
echo -e "# Pick Kernel Type       #"
echo -e "#  1. Stock Kernel       #"
echo -e "#  2. Custom Kernel      #"
echo    "##########################"

read kernel

if [ "$kernel" != "2" ]; then
	make hw_msm8930_defconfig
else
	make y301a2_defconfig
fi

make ARCH=arm CROSS_COMPILE=$CCOMPILER -j`grep 'processor' /proc/cpuinfo | wc -l`

# copy kernel and modules to out if not failed
if [ $? -eq 0 ]
then
	echo "#########################################################"
	echo "#          Copying zImage and Modules to Out            #"
	echo "#########################################################"
	mkdir -p ./out
	mkdir -p ./out/modules/
	cd out
	cp -f ../arch/arm/boot/zImage .
	cd -
	cp -r `find -iname '*.ko'` ./out/modules/
	echo "#########################################################"
	echo "#                      COMPLETED                        #"
	echo "#########################################################"
else
	echo "#########################################################"
	echo "#                       FAILED :(                       #"
	echo "#########################################################"
fi

