#!/usr/bin/env bash

cd $HOME/bootleg

rm -rf hardware/qcom/audio
rm -rf hardware/qcom/sdm845/data
rm -rf device/google/crosshatch
rm -rf device/google/blueline
rm -rf kernel/google/bluecross
rm -rf device/google/crosshatch-sepolicy
rm -rf vendor/google

git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://gitlab.com/stebomurkn420/vendor_gapps vendor/gapps
git clone https://github.com/stebomurkn420/device_google_crosshatch device/google/crosshatch
git clone https://github.com/stebomurkn420/device_google_blueline device/google/blueline
git clone https://github.com/stebomurkn420/kernel_google_bluecross kernel/google/bluecross
git clone https://github.com/stebomurkn420/device_google_crosshatch-sepolicy device/google/crosshatch-sepolicy
git clone https://github.com/choose-a/android_hardware_qcom_sdm845_data_ipacfg-mgr hardware/qcom/sdm845/data/ipacfg-mgr
git clone https://github.com/DirtyUnicorns/android_vendor_google vendor/google

. build/envsetup.sh
lunch bootleg_blueline-userdebug
make bacon -j32 |& tee /tmp/build.log
