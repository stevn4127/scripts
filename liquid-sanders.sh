#!/usr/bin/env bash

bash <(curl https://raw.githubusercontent.com/stebomurkn420/scripts/master/install-build-tools.sh)

mkdir liquid

cd $HOME/liquid

rm -rf hardware/qcom/audio
rm -rf device/google/bonito
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf kernel/google/bonito
rm -rf vendor/gapps
rm -rf hardware/qcom/sdm710

git clone https://github.com/LiquidRemixSanders/device_motorola_sanders.git -b 9x device/motorola/sanders
git clone https://github.com/LiquidRemixSanders/vendor_motorola_sanders.git -b 9.0 vendor/motorola/sanders
git clone https://github.com/LiquidRemixSanders/android_kernel_motorola_msm8953.git -b 9.0-eas-caf kernel/motorola/msm8953

. build/envsetup.sh
lunch liquid_sanders-userdebug
mka liquid -j32 |& tee /tmp/build.log
