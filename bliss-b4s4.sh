#!/usr/bin/env bash

cd

echo "Installing build tools to compile the ROM"
sleep 5
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot
echo "Installing build tools COMPLETED"
sleep 5

mkdir bliss
echo "Created bliss directory"
sleep 5

mkdir -p ~/bin
echo "Running... mkdir -p ~/bin"
sleep 5

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo "Running... curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo"

chmod a+x ~/bin/repo
echo "Running... a+x ~/bin/repo"
sleep 5

cd $HOME/bliss
echo "CD into Home/bliss"

echo "Initiating manifest. You may need to select Y/N here or git config --global user.email and git config --global user.name"
repo init -u https://github.com/BlissRoms/platform_manifest.git -b q
sleep 5

echo "The project will now sync all of the repositories needed to compile the ROM. Depending on your connection this could take a while! You can expect a 1 hour sync time on a connection of 100mb/s Download speed."
sleep 7

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j32
echo "Repo syncing is complete"
sleep 5

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps
echo "Removed any lingering dogshit"
sleep 5

echo "Now cloning the appropriate trees for Bonito"
sleep 5

git clone https://github.com/BlissRoms-Devices/android_device_google_bonito device/google/bonito
echo "Cloning device tree for Bonito"
git clone https://github.com/BlissRoms-Devices/android_kernel_google_b4s4 kernel/google/b4s4
echo "Cloning Dank kernel"
git clone https://github.com/BlissRoms-Devices/proprietary_vendor_google vendor/google
echo "Cloning proprietary vendor blobs"
git clone https://gitlab.com/stebomurkn420/gapps.git -b bliss vendor/gapps
echo "Cloning Gapps"

echo "Now starting the build. Lets roll another joint!"
sleep 5

echo "Initializing build enviroment"
. build/envsetup.sh
sleep 5

echo "Running lunch command"
lunch bliss_bonito-userdebug

echo "Starting the build with mka blissify"
mka blissify |& tee /tmp/build.log

