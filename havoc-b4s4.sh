#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

#git config --global user.email
#git config --global user.name

cd

mkdir havoc

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/havoc

repo init -u https://github.com/Havoc-OS/android_manifest.git -b ten

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

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

git clone https://github.com/stebomurkn420/Bonito -b havoc device/google/bonito
git clone https://android.googlesource.com/device/sample device/sample
git clone https://github.com/shagbag913/android_vendor_google vendor/google
git clone https://github.com/stebomurkn420/kernel_google_b4s4 kernel/google/b4s4
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.1 vendor/gapps
git clone https://github.com/LineageOS/android_hardware_qcom_sdm845_display hardware/qcom/sdm845/display

. build/envsetup.sh

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache

lunch havoc_bonito-userdebug

make bacon -j$(nproc --all) |& tee /tmp/build.log

lunch havoc_sargo-userdebug

make bacon -j$(nproc --all) |& tee /tmp/build.log
