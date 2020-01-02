#!/usr/bin/env bash

bash <(curl https://raw.githubusercontent.com/stebomurkn420/scripts/master/install-build-tools.sh)

mkdir havoc

cd $HOME/havoc

repo init -u https://github.com/Havoc-OS/android_manifest.git -b ten

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/stebomurkn420/Bonito -b havoc device/google/bonito
git clone https://android.googlesource.com/device/sample device/sample
git clone https://android.googlesource.com/device/google/bonito-sepolicy -b android-10.0.0_r12 device/google/bonito-sepolicy
git clone https://GitHub.com/gahsrom/vendor_google vendor/google
git clone https://github.com/stebomurkn420/kernel_google_b4s4 kernel/google/b4s4
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.0 vendor/gapps
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_display hardware/qcom/sdm710/display
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_gps hardware/qcom/sdm710/gps
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_media hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r47 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r47 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_data_ipacfg-mgr -b bliss hardware/qcom/sdm710/data/ipacfg-mgr

. build/envsetup.sh

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache

brunch bonito |& tee /tmp/build.log
