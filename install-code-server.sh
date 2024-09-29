#!/bin/bash

# Step 1: Download the latest version of Code Server
# Replace with the latest version manually or make dynamic (advanced task)
CODE_SERVER_VERSION="4.93.1"
DEB_FILE="code-server_${CODE_SERVER_VERSION}_amd64.deb"
DOWNLOAD_URL="https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/${DEB_FILE}"

echo "Downloading Code Server version ${CODE_SERVER_VERSION}..."
wget $DOWNLOAD_URL -O /tmp/$DEB_FILE

# Step 2: Install the deb package using dpkg
echo "Installing Code Server..."
sudo dpkg -i /tmp/$DEB_FILE

# Step 3: Create the systemd service file for Code Server
SERVICE_FILE="/usr/lib/systemd/system/code-server.service"
echo "Creating systemd service file for Code Server..."

sudo tee $SERVICE_FILE > /dev/null <<EOL
[Unit]
Description=code-server
After=nginx.service

[Service]
User=root
Type=simple
Environment=PASSWORD=kali
ExecStart=/usr/bin/code-server --bind-addr 0.0.0.0:8080 --user-data-dir /var/lib/code-server --auth password
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Step 4: Reload systemd to recognize the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Step 5: Start the Code Server service
echo "Starting Code Server..."
sudo systemctl start code-server

# Step 6: Enable the Code Server service to start on boot
echo "Enabling Code Server to start on boot..."
sudo systemctl enable code-server

# Step 7: Check status of the Code Server service
echo "Code Server installation complete. Checking service status..."
sudo systemctl status code-server
#!/bin/bash

# Step 1: Download the latest version of Code Server
# Replace with the latest version manually or make dynamic (advanced task)
CODE_SERVER_VERSION="4.93.1"
DEB_FILE="code-server_${CODE_SERVER_VERSION}_amd64.deb"
DOWNLOAD_URL="https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/${DEB_FILE}"

echo "Downloading Code Server version ${CODE_SERVER_VERSION}..."
wget $DOWNLOAD_URL -O /tmp/$DEB_FILE

# Step 2: Install the deb package using dpkg
echo "Installing Code Server..."
sudo dpkg -i /tmp/$DEB_FILE

# Step 3: Create the systemd service file for Code Server
SERVICE_FILE="/usr/lib/systemd/system/code-server.service"
echo "Creating systemd service file for Code Server..."

sudo tee $SERVICE_FILE > /dev/null <<EOL
[Unit]
Description=code-server
After=nginx.service

[Service]
User=root
Type=simple
Environment=PASSWORD=kali
ExecStart=/usr/bin/code-server --bind-addr 0.0.0.0:8080 --user-data-dir /var/lib/code-server --auth password
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Step 4: Reload systemd to recognize the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Step 5: Start the Code Server service
echo "Starting Code Server..."
sudo systemctl start code-server

# Step 6: Enable the Code Server service to start on boot
echo "Enabling Code Server to start on boot..."
sudo systemctl enable code-server

# Step 7: Check status of the Code Server service
echo "Code Server installation complete. Checking service status..."
sudo systemctl status code-server
