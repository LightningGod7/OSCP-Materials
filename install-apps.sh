#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install apps
echo "Installing apps..."
sudo apt install -y diodon donut terminator rlwrap freerdp2-x11 libkrb5-dev bloodyAD npm ligolo-ng

# Install linux-powerview
pipx install "git+https://github.com/aniqfakhrul/powerview.py"

#Install rustscan
echo "Installing rustscan"
sudo wget https://github.com/RustScan/RustScan/releases/download/2.3.0/rustscan-2.3.0-x86_64-linux.zip -O /home/kali/Downloads/rustscan-2.3.0-x86_64-linux.zip
sudo unzip /home/kali/Downloads/rustscan-2.3.0-x86_64-linux.zip
sudo mv /home/kali/Downloads/tmp/rust*/rustscan /usr/bin/rustscan

echo "rustscan post-install cleanup"
sudo rm -rf /home/kali/Downloads/tmp/
sudo rm -rf home/kali/Downloads/rustscan*
# Verify the installations
echo "Verifying installations..."
for pkg in diodon terminator ligolo rlwrap freerdp2-x11 npm rustscan; do
    if dpkg -l | grep -q "$pkg"; then
        echo "$pkg is installed."
    else
        echo "$pkg failed to install."
    fi
done

echo "All installations complete!"

echo "starting apache service"
sudo systemctl start apache2
sudo systemctl enable apache2
