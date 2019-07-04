#!/usr/bin/env bash

sudo apt install repo

sudo apt install libncurses5

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev

sudo apt install openjdk-8-jdk

cd

mkdir bootleg

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/bootleg

repo init -u https://github.com/BootleggersROM/manifest.git -b pasta

repo sync --force-sync -j32

rm -rf device/google/bonito
rm -rf hardware/qcom/audio
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf vendor/google
rm -rf kernel/google/bonito
rm -rf hardware/google/pixel
rm -rf vendor/gapps
rm -rf hardware/qcom/sdm710

git clone https://github.com/stebomurkn420/device_google_bonito device/google/bonito
git clone https://github.com/stebomurkn420/device_google_bonito-sepolicy device/google/bonito-sepolicy
git clone https://github.com/stebomurkn420/vendor_google vendor/google
git clone --recurse-submodules https://github.com/stebomurkn420/Dank_kernel_google_bonito kernel/google/bonito
git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://github.com/DirtyUnicorns/android_hardware_google_pixel hardware/google/pixel
git clone https://gitlab.com/stebomurkn420/vendor_gapps vendor/gapps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r42 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r42 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r42 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r42 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r42 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr

. build/envsetup.sh
lunch bootleg_bonito-userdebug
make bacon -j32 |& tee /tmp/build.log
