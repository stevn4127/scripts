#!/usr/bin/env bash

cd

sudo apt update

sudo apt upgrade -y

echo "Installing build tools to compile the ROM"
sleep 5
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot
echo "Installing build tools COMPLETED"
sleep 5

mkdir los
echo "Created lineage directory"
sleep 5

mkdir -p ~/bin
echo "Running... mkdir -p ~/bin"
sleep 5

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo "Running... curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo"

chmod a+x ~/bin/repo
echo "Running... a+x ~/bin/repo"
sleep 5

cd $HOME/los
echo "CD into Home/los"

rm -rf frameworks/base

echo "Initiating manifest. You may need to select Y/N here or git config --global user.email and git config --global user.name"
repo init -u git://github.com/LineageOS/android.git -b lineage-17.1
sleep 5

echo "The project will now sync all of the repositories needed to compile the ROM. Depending on your connection this could take a while! You can expect a 1 hour sync time on a connection of 100mb/s Download speed."
sleep 7

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j32
echo "Repo syncing is complete"
sleep 5

cd frameworks/base

git remote add shag https://github.com/GahsROM/platform_frameworks_base
echo "Adding remote"
sleep 3

git fetch shag
echo "fetching remote"
sleep 3

git cherry-pick 9cefdf0bbfb88759c445c226915d3535986c3184 590e923fb15818b20f45aa95a52fdc3ad0a32d2b
echo "Cherry-picking alternate accent tint"

cd

cd los

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf packages/apps/Trebuchet
rm -rf packages/apps/Launcher3
rm -rf vendor/gapps
echo "Remove any lingering dogshit"
sleep 5

echo "Now cloning the appropriate trees for Bonito"
sleep 5

git clone https://github.com/stevn4127/Bonito -b lineage device/google/bonito
echo "Cloning device tree for Bonito"
git clone https://github.com/BlissRoms-Devices/android_kernel_google_b4s4 kernel/google/b4s4
echo "Cloning Dank kernel"
git clone https://github.com/BlissRoms-Devices/proprietary_vendor_google vendor/google
echo "Cloning proprietary vendor blobs"
git clone https://gitlab.com/stebomurkn420/gapps.git -b los vendor/gapps
echo "Cloning Gapps"
git clone https://github.com/BlissRoms/platform_packages_apps_Launcher3 packages/apps/Launcher3
echo "Cloning Bliss launcher"

echo "Now starting the build. Lets roll another joint!"
sleep 5

echo "Initializing build enviroment"
. build/envsetup.sh
sleep 5

make clean
echo "Cleaning build enviroment"
sleep 3

echo "Running lunch command"
lunch lineage_bonito-userdebug

echo "Starting the build with mka bacon"
make bacon
