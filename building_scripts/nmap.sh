#!/bin/bash
sudo apt-get update
sudo apt-get install libssh2-1-dev libssl-dev libsvn-dev g++ checkinstall -y
 
echo "=== Building package ==="
url=`curl https://nmap.org/download.html | egrep "stable.*release tarball" | egrep -o "https://nmap[^\"]*bz2"`
wget "$url"
dir_name=`ls | sed 's/\.tar\.bz2//'`
bzip2 -cd $dir_name.tar.bz2 | tar xvf -
cd $dir_name
./configure
make
version=`echo $dir_name | sed 's/.*-//'`
sudo checkinstall --pkgname "nmap" --pkgversion "$version" --maintainer "avleonov" -y

echo "=== Correcting dependencies ==="
curl -s https://packages.ubuntu.com/bionic/amd64/nmap/download | grep "<li>" | head -n 1 | egrep -o "http://[^\"]*" | xargs -i wget -q '{}' -O nmap.deb;
depends=`dpkg -I nmap.deb  | grep "Depends" | sed 's/^ *//'`;
depends=$depends", libssh2-1-dev, libssl-dev, libsvn-dev";
echo "$depends"
filename=`ls nmap_*.deb` 
cp $filename "no_deps_"$filename
sudo rm -rf nmap_dpkg
mkdir nmap_dpkg
dpkg-deb -x $filename nmap_dpkg
dpkg-deb --control $filename nmap_dpkg/DEBIAN
echo "$depends" >> nmap_dpkg/DEBIAN/control
sudo dpkg -b nmap_dpkg $filename
dpkg -I $filename

echo "=== Installing with dependencies ==="
sudo dpkg -i $filename
sudo apt-get install -f -y

echo "=== Copying package file ==="
cp $filename /vagrant/package

