#!/usr/bin/env bash

git clone https://android.googlesource.com/device/google/bonito -b platform-tools-29.0.2 device/google/bonito
git clone https://github.com/stebomurkn420/device_google_bonito-sepolicy device/google/bonito-sepolicy
git clone https://github.com/stebomurkn420/vendor_google -b liquid vendor/google
git clone https://android.googlesource.com/device/google/bonito-kernel -b platform-tools-29.0.2 device/google/bonito-kernel
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r45 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r45 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r45 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r45 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r45 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr
