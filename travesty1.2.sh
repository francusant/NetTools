#!/bin/sh

# Script created by Francisco Santistevan on 2024-02-26

echo "TRAVESTY v1.2 by Francisco Santistevan"
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
echo "Installing wget"
yum -y install wget 
echo "Installing tar"
yum -y install tar
echo "Installing zip"
yum -y install zip 
echo "Installing popt.i686"
yum -y install popt.i686 
echo "Installing zlib.i686"
yum -y install zlib.i686
echo "Installing expat-devel.i686"
yum -y install expat-devel.i686
echo "Installing glib2.i686"
yum -y install glib2.i686
echo "Installing libnsl.i686"
yum -y install libnsl.i686
echo "Installing libxcrypt-compat.i686"
yum -y install libxcrypt-compat.i686
echo "Installing libicu.x86_64"
yum -y install libicu.x86_64
echo "Installing libstdc++.so.6"
yum -y install libstdc++.so.6
echo "Installing fontconfig.x86_64"
yum -y install fontconfig.x86_64
echo ""
echo ""
echo ""

echo "Step 4: Installing Graphical Interface (Optional)"
sudo dnf -y groupinstall "Server with GUI"
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
cd /root/Downloads/traverse9.7/
pwd
echo ""
echo ""

echo"Step 7: Installing Traverse:"
echo"Please pay attention to this section, and make sure to save your configurations for future reference"
echo" "
echo"Current Directory:"
pwd
sh ./install.sh


echo "Please reboot the system to apply changes."
echo ""
