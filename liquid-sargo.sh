#!/usr/bin/env bash

cd

# Functions
function clean_all {
		make clean
}

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk

cd

mkdir liquid

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/liquid

repo init -u git://github.com/LiquidRemix/android_manifest.git -b ten

repo sync --force-sync -j32

rm -rf device/google/bonito
rm -rf device/qcom
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf kernel/google/bonito
rm -rf vendor/gapps
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845

git clone https://github.com/stebomurkn420/Bonito -b ten device/google/bonito
git clone https://github.com/stebomurkn420/Sargo -b ten device/google/sargo
git clone https://android.googlesource.com/device/google/bonito-sepolicy -b android-10.0.0_r2 device/google/bonito-sepolicy
git clone https://github.com/UnicornioSucio/android_vendor_google vendor/google
git clone https://github.com/UnicornioSucio/android_kernel_google_bluecross kernel/google/bluecross
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.0 vendor/gapps
git clone https://gitlab.com/stebomurkn420/vendor_images.git -b ten vendor/images
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/display -b android-9.0.0_r47 hardware/qcom/sdm710/display
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/gps -b android-9.0.0_r47 hardware/qcom/sdm710/gps
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/media -b android-9.0.0_r47 hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r47 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r47 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/hardware_qcom_sdm710_data_ipacfg-mgr hardware/qcom/sdm710/data/ipacfg-mgr

. build/envsetup.sh

echo

while read -p "Do you want to make clean (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

lunch liquid_sargo-userdebug

mka bacon -j32 |& tee /tmp/build.log
