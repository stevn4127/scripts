#!/usr/bin/env bash

cd

echo "Installing build tools..."

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

#git config --global user.email
#git config --global user.name

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

mkdir DU

cd $HOME/DU

repo init -u https://github.com/DirtyUnicorns/android_manifest.git -b q10x

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo "Sit back and smoke a joint!"

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/DirtyUnicorns/android_kernel_google_bluecross kernel/google/bluecross
git clone https://github.com/DirtyUnicorns/android_vendor_google vendor/google
git clone https://github.com/DirtyUnicorns/android_device_google_bonito device/google/bonito
git clone https://gitlab.com/DirtyUnicorns/android_vendor_pixelgapps.git vendor/pixelgapps
git clone https://gitlab.com/DirtyUnicorns/android_vendor_images vendor/images
git clone https://github.com/DirtyUnicorns/android_device_google_bonito-sepolicy device/google/bonito-sepolicy
git clone https://github.com/DirtyUnicorns/android_device_google_sargo device/google/sargo

echo "Sit back and smoke a joint! Starting the ROM build!"

. build/envsetup.sh

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache

lunch du_bonito-userdebug

make bacon -j16 |& tee /tmp/build.log