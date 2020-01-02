#!/usr/bin/env bash

# Used to test distro name
source /etc/os-release

# Only support Ubuntu
if [[ "$NAME" != "Ubuntu" ]]; then
    echo "Script is only supported on Ubuntu! Exiting."
    exit 1
fi

BUILD_PACKAGES=(
    "bc"
    "bison"
    "build-essential"
    "ccache"
    "curl"
    "flex"
    "g++-multilib"
    "gcc-multilib"
    "git"
    "gnupg"
    "gperf"
    "imagemagick"
    "lib32ncurses5-dev"
    "lib32readline-dev"
    "lib32z1-dev"
    "liblz4-tool"
    "libncurses5-dev"
    "libsdl1.2-dev"
    "libssl-dev"
    "libwxgtk3.0-dev"
    "libxml2"
    "libxml2-utils"
    "lzop"
    "pngcrush"
    "rsync"
    "schedtool"
    "squashfs-tools"
    "xsltproc"
    "zip"
    "zlib1g-dev"
    "libncurses5"
    "git"
    "repo"
    "openjdk-8-jdk"
    "fastboot"
    "adb"
)

INSTALLED_PACKAGES=($(apt list --installed | cut -d '/' -f 1))

# Determine which packages we'll need to install
for needed_package in "${BUILD_PACKAGES[@]}"; do
    package_found=false
    for installed_package in "${INSTALLED_PACKAGES[@]}"; do
        if [[ $needed_package = $installed_package ]]; then
            package_found=true
        fi
    done
    if [[ $package_found != true ]]; then
        NEED_TO_INSTALL_PACKAGES+=("$needed_package")
    fi
done

# Install needed packages
sudo apt install "${NEED_TO_INSTALL_PACKAGES[@]}"
