#!/usr/bin/env bash

cd $HOME/googledrive/Liquid
rm liquid*.zip
cd $HOME/liquid

git clone https://github.com/LiquidRemixSanders/device_motorola_sanders device/motorola/sanders
git clone https://github.com/LiquidRemixSanders/android_kernel_motorola_msm8953 kernel/motorola/msm8953
git clone https://github.com/LiquidRemixSanders/vendor_motorola_sanders vendor/motorola/sanders

bash tg_bot "Starting Liquid Remix build for sanders by @Isyedsajid Watch the LIVE build [HERE](https://www.twitch.tv/stebomurkn420) $1"
rm /tmp/build.log
. build/envsetup.sh
make clean
lunch liquid_sanders-userdebug
mka liquid -j32 |& tee /tmp/build.log
bash tg_bot "Liquid Remix build for sanders successful, UPLOADING..."
    (
        cd out/target/product/sanders
        cp $(ls liquid*.zip | sort | tail -n 1) $HOME/googledrive/Liquid
    )
        bash tg_bot "Liquid Remix build for Sanders uploaded @Isyedsajid Donwload the ROM [HERE](https://drive.google.com/open?id=1j3dOX0s1NQmSN_VdlVhhPKLdO2htQIM0)"
    fi
