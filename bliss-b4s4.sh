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

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j32

cd $HOME/bliss

. build/envsetup.sh

lunch bliss_bonito-userdebug

repo sync

make blissify |& tee /tmp/build.log

cd

cd bliss

. build/envsetup.sh

lunch bliss_sargo-userdebug

make blissify |& tee /tmp/build.log
