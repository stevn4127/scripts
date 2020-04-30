#!/usr/bin/env bash

cd

echo "Installing build tools..."

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

#git config --global user.email
#git config --global user.name

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

mkdir gahs

cd $HOME/gahs

repo init -u https://github.com/GahsROM/platform_manifest.git -b ten

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo "Sit back and smoke a joint! Repo syncing..."

git clone https://github.com/GahsROM/device_google_bonito device/google/bonito
git clone https://github.com/GahsROM/vendor_google vendor/google
git clone https://github.com/GahsROM/device_google_bonito-kernel device/google/bonito-kernel
git clone https://gitlab.com/shagbag913/vendor_gapps.git vendor/gapps

. build/envsetup.sh

lunch gahs_bonito-user

make otapackage -j16 |& tee /tmp/build.log
