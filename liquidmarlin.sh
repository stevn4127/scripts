#!/usr/bin/env bash

cd $HOME/googledrive/Liquid
rm liquid*.zip
cd $HOME/liquid

bash tg_bot "Starting Liquid Remix build for marlin by @stebomurkn420 Watch the LIVE build [HERE](https://www.twitch.tv/stebomurkn420) $1"
rm /tmp/build.log
. build/envsetup.sh
make clean
lunch liquid_marlin-userdebug
mka liquid -j6 |& tee /tmp/build.log
if [[ ${PIPESTATUS[0]} != 0 ]]; then
    for i in "FAILED" "ninja: error"; do
        if [[ $(cat /tmp/build.log | sed -ne '/'"$i"'/,$p') != "" ]]; then
            ERROR=$(cat /tmp/build.log | sed -ne '/'"$i"'/,$p')
        fi
    done
    DDLINK=$(bash deldog "$ERROR")
    if [[ -z $ERROR ]]; then
       bash tg_bot "Liquid Remix build for marlin failed, @stebomurkn420"
    else
       bash tg_bot "Liquid Remix build for marlin failed, @stebomurkn420. Error: $DDLINK"
    fi
    exit 1
else
bash tg_bot "Liquid Remix build for marlin successful"
    (
        cd out/target/product/marlin
        cp $(ls liquid*.zip | sort | tail -n 1) $HOME/googledrive/Liquid
    )
        bash tg_bot "Liquid Remix build for Marlin uploaded @stebomurkn420 Donwload the ROM [HERE](https://drive.google.com/drive/folders/1j3dOX0s1NQmSN_VdlVhhPKLdO2htQIM0/)"
    fi
