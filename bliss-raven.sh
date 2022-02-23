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

echo "Initiating manifest. You may need to select Y/N here or git config --global user.email and git config --global user.name and restart script"

#git config --global user.email
#git config --global user.name

sleep 5

repo init -u https://github.com/BlissRoms/platform_manifest.git -b arcadia
echo "The project will now sync all of the repositories needed to compile the ROM. Depending on your connection this could take a while! You can expect a 1 hour sync time on a connection of 100mb/s Download speed."
sleep 5

repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune
echo "Repo syncing is complete"
sleep 5

rm -rf frameworks/base
rm -rf build/make
rm -rf build/soong
rm -rf vendor/google
rm -rf vendor/gms
echo "Removed repos that need patches"
sleep 5

echo "Now cloning the appropriate repos for Raven"
sleep 5

git clone https://github.com/stevn4127/platform_frameworks_base -b arcadia frameworks/base
echo "Cloning patched FWB for FOD"
git clone https://github.com/stevn4127/platform_build_make -b arcadia build/make
echo "Cloning patched build/make"
git clone https://github.com/stevn4127/platform_vendor_bliss -b arcadia vendor/bliss
echo "Cloning patched vendor/bliss"
git clone https://github.com/stevn4127/platform_build_soong -b arcadia build/soong
echo "Cloning patched build/soong"
git clone https://github.com/stevn4127/device_google_raviole -b arcadia device/google/raviole
echo "Cloning device tree for Raven"
git clone https://github.com/stevn4127/android_device_google_gs101 -b arcadia device/google/gs101
echo "Cloning gs101"
git clone https://github.com/stevn4127/android_device_google_gs101-sepolicy -b arcadia device/google/gs101-sepolicy
echo "Cloning gs101-sepolicy"
git clone https://android.googlesource.com/device/google/raviole-kernel -b android-12.0.0_r32 device/googel/raviole-kernel
echo "Cloning AOSP kernel"
git clone https://gitlab.com/stebomurkn420/vendor_google -b arcadia vendor/google
echo "Cloning proprietary vendor blobs"
git clone https://gitlab.com/stebomurkn420/platform_vendor_gms -b arcadia vendor/gms
echo "Cloning gapps"


echo "Now starting the build. Lets roll another joint!"
sleep 5

echo "Initializing build enviroment"
. build/envsetup.sh
sleep 5

echo "Starting the build with mka blissify"
lunch bliss_raven-userdebug

blissify raven |& tee /tmp/build.log

