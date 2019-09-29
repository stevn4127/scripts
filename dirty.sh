#!/usr/bin/env bash

git clone https://github.com/stebomurkn420/Bonito -b ten device/google/bonito
git clone https://github.com/stebomurkn420/Sargo -b ten device/google/sargo
git clone https://android.googlesource.com/device/google/bonito-sepolicy -b android-10.0.0_r2 device/google/bonito-sepolicy
git clone https://github.com/UnicornioSucio/android_vendor_google vendor/google
git clone https://github.com/UnicornioSucio/android_kernel_google_bluecross kernel/google/bluecross
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.0 vendor/gapps
git clone https://gitlab.com/stebomurkn420/vendor_images.git -b ten vendor/images
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r47 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r47 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r47 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r47 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r47 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr

. build/envsetup.sh

lunch liquid_bonito-userdebug

mka bacon -j32 |& tee /tmp/build.log
