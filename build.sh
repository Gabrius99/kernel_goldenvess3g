#!/bin/bash

rm -v ../output/goldenvess3g/zImage
make mrproper
mkdir -p ./kernel_out
cp -f ./arch/arm/configs/pxa986_golden_rev02_defconfig ./kernel_out/.config
make -j2 ARCH=arm KBUILD_OUTPUT=./kernel_out oldnoconfig
make -j2 ARCH=arm KBUILD_OUTPUT=./kernel_out
cp -f ./kernel_out/arch/arm/boot/zImage ./arch/arm/boot/
cp -rf ./kernel_out/arch/arm/boot/compressed/vmlinux ./arch/arm/boot/compressed/
cp -rf ./kernel_out/vmlinux ./
cp ./kernel_out/arch/arm/boot/zImage ~/android/kernel/output/goldenvess3g/
echo "Compiling done, fetching libs"
find ./kernel_out -type f -name *.ko -exec cp -f {} ~/android/kernel/output/goldenvess3g/ramdisk/lib/modules \;
cd ../output/goldenvess3g/
./makeimg.sh
