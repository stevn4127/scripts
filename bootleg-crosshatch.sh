#!/usr/bin/env bash

cd $HOME/googledrive/Bootleggers/crosshatch
rm BootleggersROM*.zip
cd $HOME/bootleg

git clone https://github.com/stebomurkn420/android_device_google_crosshatch device/google/crosshatch
git clone https://github.com/DirtyUnicorns/android_device_google_crosshatch-sepolicy device/google/crosshatch-sepolicy
git clone https://github.com/DirtyUnicorns/android_vendor_google vendor/google
git clone https://github.com/DespairFactor/bluecross -b pieu kernel/google/bluecross
git clone https://github.com/LineageOS/android_hardware_qcom_audio hardware/qcom/audio
git clone https://gitlab.com/DirtyUnicorns/android_vendor_pixelgapps.git vendor/pixelgapps
git clone https://github.com/stebomurkn420/android_hardware_qcom_sdm845_data_ipacfg-mgr hardware/qcom/sdm845/data/ipacfg-mgr

bash tg_bot "Starting BootleggersROM TEST build for XHatch, check in on the progress and watch the build live [HERE](https://www.twitch.tv/stebomurkn420) by @stebomurkn420 $1"
. build/envsetup.sh
lunch bootleg_crosshatch-userdebug
make bacon -j16 |& tee /tmp/build.log
bash tg_bot "BootleggersROM TEST build for XHatch successful"
    (
        cd out/target/product/crosshatch
        cp $(ls BootleggersROM*.zip | sort | tail -n 1) $HOME/googledrive/Bootleggers/crosshatch
    )
        bash tg_bot "BootleggersROM TEST build for XHatch uploaded, This build includes Gapps! Download [HERE](https://drive.google.com/drive/folders/1uKkjgxmYecj7Usi6zciOM6k8RdQww_i_) @OldManDave, test that hide notch thingy please. lol. Enjoy!"
