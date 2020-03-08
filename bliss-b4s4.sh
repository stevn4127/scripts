#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

cd

mkdir bliss

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/bliss

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845/display
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

repo init -u https://github.com/BlissRoms/platform_manifest.git -b q

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j16

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845/display
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/BlissRoms-Devices/android_device_google_bonito -b q device/google/bonito
#git clone https://android.googlesource.com/device/sample device/sample
git clone https://github.com/BlissRoms-Devices/proprietary_android_vendor_google vendor/google
git clone https://github.com/BlissRoms-Devices/android_kernel_google_b4s4 -b q kernel/google/b4s4
git clone https://gitlab.com/shagbag913/vendor_gapps -b ten vendor/gapps
git clone https://github.com/LineageOS/android_hardware_qcom_sdm845_display -b lineage-17.1 hardware/qcom/sdm845/display

cd $HOME/bliss

. build/envsetup.sh

lunch bliss_bonito-userdebug

make blissify |& tee /tmp/build.log

cd

cd bliss

. build/envsetup.sh

lunch bliss_sargo-userdebug

make blissify |& tee /tmp/build.log
