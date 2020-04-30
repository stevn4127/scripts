#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

#git config --global user.email
#git config --global user.name
#export USE_CCACHE=1
#export CCACHE_COMPRESS=1
#export CCACHE_EXEC=/usr/bin/ccache

mkdir bootleg

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/bootleg

#rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
#rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf kernel/google/bonito
#rm -rf vendor/google
rm -rf vendor/images
#rm -rf vendor/gapps

repo init -u https://github.com/BootleggersROM/manifest.git -b queso

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j32

git clone https://github.com/stebomurkn420/Bonito -b queso device/google/bonito
git clone https://android.googlesource.com/device/sample device/sample
git clone https://github.com/stebomurkn420/kernel_google_b4s4 kernel/google/b4s4
git clone https://github.com/BlissRoms-Devices/proprietary_android_vendor_google vendor/google
git clone https://gitlab.com/shagbag913/vendor_gapps.git vendor/gapps

. build/envsetup.sh

lunch bootleg_bonito-userdebug

mka bootleg |& tee /tmp/build.log
