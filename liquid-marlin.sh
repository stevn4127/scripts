#!/usr/bin/env bash

cd $HOME/googledrive/Liquid
rm liquid*.zip
cd $HOME/liquid

git clone https://github.com/LR-Devices/device_google_marlin device/google/marlin
git clone https://github.com/LR-Devices/Dank_Kernel kernel/google/marlin
git clone https://github.com/LR-Devices/vendor_google_devices vendor/google_devices

bash tg_bot "Starting Liquid Remix build for marlin by @stebomurkn420 Watch the LIVE build [HERE](https://www.twitch.tv/stebomurkn420) $1"
rm /tmp/build.log
. build/envsetup.sh
make clean
lunch liquid_marlin-userdebug
mka liquid -j32 |& tee /tmp/build.log
bash tg_bot "Liquid Remix build for marlin successful, UPLOADING..."
    (
        cd out/target/product/marlin
        cp $(ls liquid*.zip | sort | tail -n 1) $HOME/googledrive/Liquid
    )
        bash tg_bot "Liquid Remix build for Marlin uploaded @stebomurkn420 Donwload the ROM [HERE](https://drive.google.com/open?id=1j3dOX0s1NQmSN_VdlVhhPKLdO2htQIM0)"
    fi
