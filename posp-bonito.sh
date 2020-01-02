#!/usr/bin/env bash

bash <(curl https://raw.githubusercontent.com/stebomurkn420/scripts/master/install-build-tools.sh)

cd $HOME/posp

repo init -u https://github.com/PotatoProject/manifest -b baked-release;

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
rm -rf hardware/qcom/wlan
rm -rf hardware/qcom/data/ipacfg-mgr

git clone https://github.com/stebomurkn420/device_google_bonito -b posp device/google/bonito
git clone https://github.com/stebomurkn420/device_google_bonito-sepolicy device/google/bonito-sepolicy
git clone https://github.com/stebomurkn420/vendor_google vendor/google
git clone --recurse-submodules https://github.com/stebomurkn420/Dank_Sarnito -b inline kernel/google/bonito
git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://github.com/DirtyUnicorns/android_hardware_google_pixel hardware/google/pixel
git clone https://gitlab.com/stebomurkn420/vendor_gapps vendor/gapps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r44 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r44 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r44 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r44 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r44 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr
git clone https://android.googlesource.com/platform/hardware/qcom/wlan -b android-9.0.0_r45 hardware/qcom/wlan
git clone https://android.googlesource.com/platform/hardware/qcom/data/ipacfg-mgr -b android-9.0.0_r45 hardware/qcom/data/ipacfg-mgr

. build/envsetup.sh
lunch potato_bonito-userdebug
make potato -j32 |& tee /tmp/build.log
