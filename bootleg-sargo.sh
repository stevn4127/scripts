#!/usr/bin/env bash

sudo apt install repo

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

git clone https://github.com/stebomurkn420/device_google_sargo device/google/sargo
git clone https://github.com/stebomurkn420/device_google_bonito device/google/bonito
git clone https://github.com/stebomurkn420/device_google_bonito-sepolicy device/google/bonito-sepolicy
git clone https://github.com/stebomurkn420/vendor_google vendor/google
git clone --recurse-submodules https://github.com/stebomurkn420/Dank_sarnito -b inline kernel/google/bonito
git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://github.com/DirtyUnicorns/android_hardware_google_pixel hardware/google/pixel
git clone https://gitlab.com/stebomurkn420/vendor_gapps.git vendor/gapps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r39 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r39 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r39 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r39 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r39 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr

cd $HOME/googledrive/Bootleggers/Sargo
rm BootleggersROM*.zip
rm system.img
rm boot.img
rm vbmeta.img
rm dtbo.img

cd $HOME/bootleg

bash tg_bot "Starting Bootleggers build for Sargo by @stebomurkn420 Watch the build process Live [HERE](https://www.twitch.tv/stebomurkn420) $1"

. build/envsetup.sh
lunch bootleg_sargo-userdebug
make bacon -j32 |& tee /tmp/build.log

bash tg_bot "Bootleggers build for Sargo successful! UPLOADING... There will be another notification when the upload completes!"
    (
        cd out/target/product/sargo
        cp {system.img,vbmeta.img,dtbo.img,boot.img,$(ls BootleggersROM*.zip | sort | tail -n 1)} $HOME/googledrive/Bootleggers/Sargo
    )
        bash tg_bot "Bootleggers build for Sargo uploaded! @stebomurkn420 Donwload the ROM [HERE](https://drive.google.com/drive/folders/16sV8KULhC_rXh3WPCGXfwWhprbGeadyq) $1"
