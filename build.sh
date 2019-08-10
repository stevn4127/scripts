#!/bin/bash
rm .version
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

clear

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image"
DTBIMAGE="dtb"
export CLANG_PATH=~/android/clang/clang-r353983e/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=~/android/aarch64-linux-android-4.9/aarch64-linux-android/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=${HOME}/android/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=${HOME}/android/clang/clang-r353983e/lib64:$LD_LIBRARY_PATH
DEFCONFIG="dank_defconfig"

# Kernel Details
VER="Sarnito.V1.42"

# Paths
KERNEL_DIR=`pwd`
REPACK_DIR="${HOME}/android/AnyKernel3"
PATCH_DIR="${HOME}/android/AnyKernel3/patch"
MODULES_DIR="${HOME}/android/AnyKernel3/modules"
ZIP_MOVE="${HOME}/android/sarnito-zips"
ZIMAGE_DIR="${HOME}/android/sarnito/out/arch/arm64/boot/"

# Functions
function clean_all {
		rm -rf $MODULES_DIR/*
		cd ~/android/sarnito/out/kernel
		rm -rf $DTBIMAGE
		git reset --hard > /dev/null 2>&1
		git clean -f -d > /dev/null 2>&1
		cd $KERNEL_DIR
		echo
		make clean && make mrproper
}

function make_kernel {
		echo
		rm -rf ~/android/AnyKernel3/dtbo.img
		rm -rf ~/android/AnyKernel3/Image.lz4-dtb
		make O=out CC=clang $DEFCONFIG
		make O=out CC=clang -j32

}

function make_boot {
		cp -vr $ZIMAGE_DIR/Image.lz4-dtb ~/android/AnyKernel3/Image.lz4-dtb
        cp -vr $ZIMAGE_DIR/dtbo.img ~/android/AnyKernel3/dtbo.img
}


function make_zip {
		cd ~/android/AnyKernel3/
		zip -r9 `echo $AK_VER`.zip *
		mv  `echo $AK_VER`.zip $ZIP_MOVE
		cd $KERNEL_DIR
}


DATE_START=$(date +"%s")


echo -e "${green}"
echo "-----------------"
echo "Welcome! Let's Build Dank Kernel:"
echo "-----------------"
echo -e "${restore}"


# Vars
BASE_AK_VER=""
AK_VER="$BASE_AK_VER$VER"
export LOCALVERSION=~`echo $AK_VER`
export LOCALVERSION=~`echo $AK_VER`
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=Stebomurkn420
export KBUILD_BUILD_HOST=R7-2700X

echo

while read -p "Do you want to clean the out directory (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to Smoke Dank (build the kernel) (y/n)?" dchoice
do
case "$dchoice" in
	y|Y )
		make_kernel
		make_boot
                make_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done


echo -e "${green}"
echo "-------------------"
echo "Build Completed! Time to Roll another joint!:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo
