#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

mkdir bootleg

cd $HOME/bootleg

repo init -u https://github.com/BootleggersROM/manifest.git -b pasta

repo sync -f --force-sync --no-clone-bundle -j32

rm -rf hardware/qcom/audio
rm -rf device/google/crosshatch
rm -rf kernel/google/crosshatch
rm -rf vendor/google
rm -rf kernel/google/crosshatch
rm -rf vendor/gapps
rm -rf hardware/qcom/sdm845

git clone https://github.com/stebomurkn420/android_device_google_crosshatch -b pasta device/google/crosshatch
git clone https://github.com/stebomurkn420/device_google_crosshatch-sepolicy device/google/crosshatch-sepolicy
git clone https://github.com/DirtyUnicorns/android_vendor_google vendor/google
git clone https://github.com/DirtyUnicorns/android_kernel_google_bluecross kernel/google/bluecross
git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://gitlab.com/stebomurkn420/vendor_gapps.git vendor/pixelgapps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/display -b android-10.0.0_r14 hardware/qcom/sdm845/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/gps -b android-10.0.0_r14 hardware/qcom/sdm845/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/media -b android-10.0.0_r14 hardware/qcom/sdm845/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/thermal -b android-10.0.0_r14 hardware/qcom/sdm845/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/vr -b android-10.0.0_r14 hardware/qcom/sdm845/vr
git clone https://android.googlesource.com/platform/hardware/qcom/sdm845/data/ipacfg-mgr -b android-10.0.0_r14  hardware/qcom/sdm845/data/ipacfg-mgr

. build/envsetup.sh
lunch bootleg_crosshatch-userdebug
make bacon -j32 |& tee /tmp/build.log
