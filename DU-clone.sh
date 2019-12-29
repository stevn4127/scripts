#!/usr/bin/env bash

echo "This script should be ran from the root directory of your ROM's source. This script will clone the necessary repositories for building a ROM for the Pixel 3a (Sargo) and Pixel 3a XL (Bonito). The only repo that should need modified is the device tree which needs edited for your ROM's source. Hope this helps!"

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/DirtyUnicorns/android_kernel_google_bluecross kernel/google/bluecross
git clone https://github.com/DirtyUnicorns/android_vendor_google vendor/google
git clone https://github.com/DirtyUnicorns/android_device_google_bonito device/google/bonito
git clone https://gitlab.com/DirtyUnicorns/android_vendor_pixelgapps.git vendor/pixelgapps
git clone https://gitlab.com/DirtyUnicorns/android_vendor_images vendor/images
git clone https://github.com/DirtyUnicorns/android_device_google_bonito-sepolicy device/google/bonito-sepolicy
