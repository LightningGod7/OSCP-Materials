#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install diodon
echo "Installing diodon..."
sudo apt install -y diodon

# Install terminator
echo "Installing terminator..."
sudo apt install -y terminator

# Install ligolo
echo "Installing ligolo..."
sudo apt install -y ligolo

# Install rlwrap
echo "Installing rlwrap..."
sudo apt install -y rlwrap

# Install xfreerdp
echo "Installing xfreerdp..."
sudo apt install -y freerdp2-x11

#Install npm
echo "Installing npm"
sudo apt install npm -y

#Install rustscan
echo "Installing rustscan"
sudo wget https://github.com/RustScan/RustScan/releases/download/2.3.0/rustscan-2.3.0-x86_64-linux.zip -O /home/kali/Downloads/
sudo mv /home/kali/Downloads/tmp/rust*/rustscan /usr/bin/rustscan

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
