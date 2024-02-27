#!/bin/sh

# Script created by Francisco Santistevan on 2024-02-26

echo"TRAVESTY v1.2 by Francisco Santistevan"
sleep 10
echo "Step 1: Updating and Upgrading OS:"
dnf update -y && dnf upgrade -y
echo ""
echo ""

echo "Step 2: Creating and changing Directories to ~/Downloads/"
cd ~/
mkdir Downloads
cd ~/Downloads/
pwd
echo ""
echo ""

echo "Step 3: Installing Dependencies"
dnf -y install wget tar zip popt.i686 zlib.i686 expat-devel.i686 glib2.i686 libnsl.i686 libxcrypt-compat.i686 libicu.x86_64 libstdc++.so.6 fontconfig.x86_64
echo ""
echo ""

echo "Step 4: Installing Graphical Interface (Optional)"
sudo dnf groupinstall "Server with GUI"
sudo systemctl set-default graphical.target
echo ""
echo ""

echo "Step 5: Downloading Traverse-9.7.8"
wget --no-check-certificate https://download.kaseya.com/components/traverse/v9.7.0.0/453/traverse-9.7.8-linux-alma.tar.gz
sha1sum traverse-9.7.8-linux-alma.tar.gz > traverse_download_sha1sum.log
echo ""
echo ""

echo "Step 6: Extracting Traverse:"
gunzip -c traverse-9.7.8-linux-alma.tar.gz | tar xpf -
cd ~/Downloads/traverse9.7/
pwd
echo ""
echo ""

echo"Step 7: Installing Traverse:"
echo"Please pay attention to this section, and make sure to save your configurations for future reference"
sleep 10
echo" "
echo"Current Directory:"
pwd
sleep 10
sh ./install.sh


echo "Please reboot the system to apply changes."
echo ""
