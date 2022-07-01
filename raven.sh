#!/usr/bin/env bash

rm -rf device/google/raviole
rm -rf device/google/gs101
rm -rf device/google/gs101-sepolicy
rm -rf device/google/raviole-kernel
rm -rf kernel/google
rm -rf vendor/gms
rm -rf vendor/gapps
rm -rf vendor/google


git clone https://github.com/StatiXOS/android_device_google_raviole -b sc-v2 device/google/raviole
git clone https://github.com/StatiXOS/android_device_google_raviole-kernel -b sc-v2 device/google/raviole-kernel
git clone https://github.com/StatiXOS/android_kernel_google_raviole -b sc-v2 kernel/google/raviole/raven
git clone https://gitlab.com/anayw2001/vendor_google_oriole -b sc-v2 vendor/google/oriole 
git clone https://gitlab.com/anayw2001/vendor_google_raven -b sc-v2 vendor/google/raven
git clone https://gitlab.com/statixos/android_vendor_google_gms -b sc-v2 vendor/gms
git clone https://github.com/StatiXOS/android_device_google_gs101 -b sc-v2 device/google/gs101
git clone https://github.com/StatiXOS/android_device_google_gs101-sepolicy -b sc-v2 device/google/gs101-sepolicy
git clone https://github.com/StatiXOS/android_vendor_google_interfaces -b sc-v2 vendor/google/interfaces
git clone https://gitlab.com/statixos/android_vendor_google_pixelparts -b sc-v2 vendor/google/pixelparts
