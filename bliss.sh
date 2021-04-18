#!/usr/bin/env bash

cd

echo "Installing build tools to compile the ROM"
sleep 5
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip squashfs-tools python3-mako libssl-dev ninja-build lunzip syslinux syslinux-utils gettext genisoimage gettext bc xorriso gnupg python libncurses5
echo "Installing build tools COMPLETED"
sleep 5

sudo sed -i '/cdrom/d' /etc/apt/sources.list

mkdir bliss
echo "Created bliss directory"
sleep 5

mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

sudo ln -fs /usr/bin/python2.7 /usr/bin/python3

cd $HOME/bliss
echo "CD into Home/bliss"

echo "Initiating manifest. You may need to select Y/N here or git config --global user.email and git config --global user.name"
repo init -u https://github.com/BlissRoms/platform_manifest.git -b r
sleep 5

echo "The project will now sync all of the repositories needed to compile the ROM. Depending on your connection this could take a while! You can expect a 1 hour sync time on a connection of 100mb/s Download speed."
sleep 7

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j32
echo "Repo syncing is complete"
sleep 5

echo "Removed any lingering dogshit"
sleep 5

echo "Now cloning the appropriate trees for Bonito"
sleep 5

git clone https://github.com/stevn4127/Bonito device/google/bonito
echo "Cloning device tree for Bonito"
git clone https://github.com/LineageOS/android_kernel_google_msm-4.9 kernel/google/msm-4.9
echo "Cloning Dank kernel"
git clone https://github.com/TheMuppets/proprietary_vendor_google vendor/google
echo "Cloning proprietary vendor blobs"

echo "Now starting the build. Lets roll another joint!"
sleep 5

echo "Initializing build enviroment"
. build/envsetup.sh
sleep 5

echo "Running lunch command"
lunch bliss_bonito-userdebug

echo "Starting the build with mka blissify"
mka blissify |& tee /tmp/build.log

