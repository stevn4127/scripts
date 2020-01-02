#!/bin/bash

bash <(curl https://raw.githubusercontent.com/stebomurkn420/scripts/master/install-build-tools.sh)

mkdir android
cd android
mkdir sarnito-zips

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-9.0.0_r44 aarch64-linux-android-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-9.0.0_r44 arm-linux-androideabi-4.9
git clone https://github.com/Haseo97/Clang-10.0.0 clang
git clone --recurse-submodules https://github.com/stebomurkn420/Dank_sarnito -b anykernel sarnito
git clone https://github.com/stebomurkn420/AnyKernel3 AnyKernel3

cd sarnito

bash build.sh
 
