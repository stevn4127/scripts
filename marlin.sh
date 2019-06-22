#!/usr/bin/env bash

cd $HOME/googledrive/Bootleggers/Marlin
rm BootleggersROM*.zip
cd $HOME/bootleg
rm -rf hardware/qcom/audio

git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio/default
git clone https://github.com/BootleggersROM-Devices/device_google_marlin device/google/marlin
git clone https://github.com/BootleggersROM-Devices/device_google_marlin kernel/google/marlin
git clone https://github.com/BootleggersROM-Devices/vendor_google vendor/google
git clone https://gitlab.com/stebomurkn420/vendor_gapps.git vendor/gapps

bash tg_bot "Starting BootleggersROM TEST build for Marlin. Watch the build process live [HERE](https://www.twitch.tv/stebomurkn420) $1"
rm /tmp/build.log
. build/envsetup.sh
lunch bootleg_marlin-userdebug
make bacon -j32 |& tee /tmp/build.log
bash tg_bot "BootleggersROM TEST build for marlin successful"
    (
        cd out/target/product/marlin
        cp $(ls BootleggersROM*.zip | sort | tail -n 1) $HOME/googledrive/Bootleggers/Marlin
    )
        bash tg_bot "BootleggersROM TEST build for Marlin uploaded, This build includes Gapps! Download [HERE](https://drive.google.com/drive/folders/1o1xDa6dV_r_JazzE_Yw2o1W4T0webjLY) Enjoy!"
