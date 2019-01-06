#!/bin/bash

distribution="ubuntu"
release="bionic64"
nmap_folder_name="nmap_"+$distribution+"_"+$release
mkdir vagrants
rm -rf vagrants/$nmap_folder_name
mkdir vagrants/$nmap_folder_name
mkdir vagrants/$nmap_folder_name/package
cp building_scripts/nmap.sh vagrants/$nmap_folder_name/script.sh
cd vagrants/$nmap_folder_name/
vagrant init ubuntu/bionic64
vagrant up
vagrant ssh -c "sudo chmod +x /vagrant/script.sh; ls -al /vagrant/script.sh;"
vagrant ssh -c "sudo /vagrant/script.sh"
vagrant destroy -f
cd ../../
mkdir packages
cp vagrants/$nmap_folder_name/package/* packages
