#!/usr/bin/env bash

cd

sudo apt update
sudo apt upgrade

echo "Installing build tools to compile the ROM"
sleep 5
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip squashfs-tools python-mako libssl-dev ninja-build lunzip syslinux syslinux-utils gettext genisoimage gettext bc xorriso xmlstarlet
echo "Installing build tools COMPLETED"
sleep 5

#sudo sed -i '/cdrom/d' /etc/apt/sources.list

mkdir bliss
echo "Created bliss directory"
sleep 5

sudo wget 'https://storage.googleapis.com/git-repo-downloads/repo' -P /usr/local/sbin/
sudo chmod +x /usr/local/sbin/repo

cd bliss
echo "CD into Home/bliss"

echo "Initiating manifest. You may need to select Y/N here or git config --global user.email and git config --global user.name"

#git config --global user.email
#git config --global user.name

sleep 5

repo init -u https://github.com/BlissRoms/platform_manifest.git -b arcadia
echo "The project will now sync all of the repositories needed to compile the ROM. Depending on your connection this could take a while! You can expect a 1 hour sync time on a connection of 100mb/s Download speed."
sleep 5

repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune
echo "Repo syncing is complete"
sleep 5

rm -rf hardware/qcom/wlan
echo "Removed any lingering dogshit"
sleep 5

echo "Now cloning the appropriate repos for Bonito"
sleep 5

git clone https://github.com/BlissRoms-Devices/android_device_google_bonito -b arcadia device/google/bonito
echo "Cloning device tree for Bonito"
git clone https://github.com/LineageOS/android_kernel_google_msm-4.9 -b lineage-19.0 kernel/google/msm-4.9
echo "Cloning Dank kernel"
git clone https://github.com/TheMuppets/proprietary_vendor_google -b lineage-19.0 vendor/google
echo "Cloning proprietary vendor blobs"
git clone https://github.com/LineageOS/android_hardware_qcom_wlan -b lineage-19.0 hardware/qcom/wlan
echo "Replacing hardware/qcom/wlan with LineageOS repo"

echo "Now starting the build. Lets roll another joint!"
sleep 5

echo "Initializing build enviroment"
. build/envsetup.sh
sleep 5

echo "Starting the build with mka blissify"
blissify bonito |& tee /tmp/build.log

