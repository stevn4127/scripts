#!/usr/bin/env bash

echo "This script should be ran from the root directory of your ROM's source. This script will clone the necessary repositories for building a ROM for the Pixel 3a (Sargo) and Pixel 3a XL (Bonito). The only repo that should need modified is the device tree which needs edited for your ROM's source. Hope this helps!"

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps
rm -rf hardware/qcom/sdm845/display

git clone https://github.com/stebomurkn420/Bonito -b havoc device/google/bonito
git clone https://android.googlesource.com/device/sample device/sample
git clone https://github.com/shagbag913/android_vendor_google vendor/google
git clone https://github.com/stebomurkn420/kernel_google_b4s4 -b upstream kernel/google/b4s4
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.1 vendor/gapps
git clone https://github.com/LineageOS/android_hardware_qcom_sdm845_display hardware/qcom/sdm845/display
