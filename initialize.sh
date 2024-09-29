#!/bin/bash

# Step 1: Clone the repository
echo "Cloning the OSCP Materials repository..."
git clone https://github.com/LightningGod7/OSCP-Materials.git /tmp/oscp-materials

# Step 2: Move files to the desired directories
echo "Moving files to /opt and setting permissions..."
sudo mv /tmp/oscp-materials/ref /opt/ref
sudo mv /tmp/oscp-materials/rs /opt/rs
sudo mv /tmp/oscp-materials/makepwn.py /opt/makepwn

# Step 3: Make the files executable
echo "Making files executable..."
sudo chmod +x /opt/ref /opt/rs /opt/makepwn

# Step 4: Add /opt to the PATH if it's not already there
if ! grep -q "/opt" <<< "$PATH"; then
    echo "Adding /opt to PATH..."
    echo 'export PATH=$PATH:/opt' | sudo tee -a ~/.zshrc
fi

# Step 5: Create directories for reference materials
echo "Creating /pt and /pt/reference directories..."
sudo mkdir -p /pt/reference

# Step 6: Move reference files to the reference directory
echo "Moving cheatsheet and upshell to /pt/reference..."
sudo mv /tmp/oscp-materials/cheatsheet /pt/reference/cheatsheet
sudo mv /tmp/oscp-materials/upshell /pt/reference/upshell

# Step 7: Append the contents of alias.txt to ~/.zshrc
echo "Appending aliases to ~/.zshrc..."
if [ -f /tmp/oscp-materials/alias.txt ]; then
    cat /tmp/oscp-materials/alias.txt >> ~/.zshrc
else
    echo "alias.txt not found in repository!"
fi

# Step 8: Source the updated ~/.zshrc
echo "Sourcing ~/.zshrc to apply changes..."
source ~/.zshrc

echo "Script completed successfully."
