#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk

cd

mkdir liquid

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

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
