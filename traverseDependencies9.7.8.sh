#!/bin/sh
echo "Step 1: Updating and Upgrading OS:"
dnf update -y && dnf upgrade -y
echo "Step 2: Downloading traverse:"
cd ~/Downloads/
wget --no-check-certificate https://download.kaseya.com/components/traverse/v9.7.0.0/453/traverse-9.7.8-linux-alma.tar.gz
sha1sum traverse-9.7.8-linux-alma.tar.gz
echo "660d0432a0c97884dfff9894c53a08697f1e4ff1  traverse-9.7.8-linux-alma.tar.gz -- Does it match? If not stop the installation"
echo "Step 3: Installing Dependencies"
yum -y install curl 
yum -y install wget 
yum -y install tar
yum -y install zip 
yum -y install popt.i686 
yum -y install zlib.i686
yum -y install expat-devel.i686
yum -y install glib2.i686
yum -y install libnsl.i686
yum -y install libxcrypt-compat.i686
yum -y install libicu.x86_64
yum -y install libstdc++.so.6
yum -y install fontconfig.x86_64
