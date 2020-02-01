#!/usr/bin/env bash

cd

bash <(curl https://raw.githubusercontent.com/stebomurkn420/scripts/e7bf83207ec633aa5327415b4f0c58df1bdfd1b7/install-build-tools.sh)

cd

mkdir bliss

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/bliss

repo init -u https://github.com/BlissRoms/platform_manifest.git -b q

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j8

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845/display
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/stebomurkn420/Bonito -b bliss device/google/bonito
git clone https://android.googlesource.com/device/sample device/sample
git clone https://github.com/shagbag913/android_vendor_google vendor/google
git clone https://github.com/stebomurkn420/kernel_google_b4s4 kernel/google/b4s4
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.1 vendor/gapps
git clone https://github.com/LineageOS/android_hardware_qcom_sdm845_display hardware/qcom/sdm845/display

cd $HOME/bliss

. build/envsetup.sh
lunch bliss_bonito-userdebug
make blissify -j32 |& tee /tmp/build.log
