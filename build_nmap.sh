#!/bin/bash

rm -rf vagrants/nmap_ubuntu_bionic64
mkdir vagrants/nmap_ubuntu_bionic64
mkdir vagrants/nmap_ubuntu_bionic64/package
cp building_scripts/nmap.sh vagrants/nmap_ubuntu_bionic64/script.sh
cd vagrants/nmap_ubuntu_bionic64/
vagrant init ubuntu/bionic64
vagrant up
vagrant ssh -c "sudo chmod +x /vagrant/script.sh; ls -al /vagrant/script.sh;"
vagrant ssh -c "sudo /vagrant/script.sh"
vagrant destroy -f
cd ../../
cp vagrants/nmap_ubuntu_bionic64/package/* packages
