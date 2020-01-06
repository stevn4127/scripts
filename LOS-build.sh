#!/usr/bin/env bash

cd

echo "Installing build tools..."

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

#git config --global user.email
#git config --global user.name

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

mkdir los

cd $HOME/los

repo init -u git://github.com/LineageOS/android.git -b lineage-17.1

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo "Sit back and smoke a joint!"

rm -rf frameworks/base
rm -rf packages/apps/Settings
rm -rf packages/apps/SettingsIntelligence
rm -rf packages/apps/ThemePicker
rm -rf vendor/extra
rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf kernel/google
rm -rf vendor/google
rm -rf vendor/gapps

git clone https://github.com/shagbag913/android_frameworks_base frameworks/base
git clone https://github.com/shagbag913/android_packages_apps_Settings packages/apps/Settings
git clone https://github.com/shagbag913/android_packages_apps_SettingsIntelligence packages/apps/SettingsIntelligence
git clone https://github.com/shagbag913/android_packages_apps_ThemePicker packages/apps/ThemePicker
git clone https://github.com/shagbag913/android_vendor_extra vendor/extra
git clone https://github.com/shagbag913/android_device_google_bonito device/google/bonito
git clone https://github.com/shagbag913/android_vendor_google vendor/google
git clone https://github.com/shagbag913/android_kernel_google_msm-4.9 kernel/google/msm-4.9

. build/envsetup.sh

lunch lineage_bonito-userdebug

make bacon -j16 |& tee /tmp/build.log
