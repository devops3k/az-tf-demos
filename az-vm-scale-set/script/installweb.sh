#!/bin/bash

# Check if jq is installed, if not install it
if ! command -v jq &> /dev/null
then
    sudo apt-get update
    sudo apt-get install -y jq
fi

# Check if nginx is installed, if not install it
if ! command -v nginx &> /dev/null
then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Fetch metadata
vm_id=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmId?api-version=2020-09-01&format=text")
vm_size=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmSize?api-version=2020-09-01&format=text")
location=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2020-09-01&format=text")
availability_zone=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/zone?api-version=2020-09-01&format=text")
network_interface=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface?api-version=2020-09-01" | jq -r '.[] | "\(.ipv4.ipAddress[].privateIpAddress), \(.ipv4.ipAddress[].publicIpAddress), \(.ipv4.subnet[].address), \(.ipv4.subnet[].prefix), \(.macAddress)"')
public_ip=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2020-09-01&format=text")
vm_scale_set_name=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmScaleSetName?api-version=2020-09-01&format=text")

# Create HTML file
sudo bash -c "cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Azure VM Diagnostic Page</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f9; }
        h1 { color: #336699; }
        h2 { color: #334455; }
        p { font-size: 16px; color: #333; }
        .container { max-width: 800px; margin: auto; padding: 20px; background: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 8px; }
        .label { font-weight: bold; color: #555; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Linux VM using Terraform</h1>
        <h2>Azure Instance Metadata</h2>
        <p><span class="label">VM ID:</span> $vm_id</p>
        <p><span class="label">VM Size:</span> $vm_size</p>
        <p><span class="label">Location:</span> $location</p>
        <p><span class="label">Availability Zone:</span> $availability_zone</p>
        <p><span class="label">Network Interface:</span> $network_interface</p>
        <p><span class="label">Public IP Address:</span> $public_ip</p>
        <p><span class="label">VM Scale Set Name:</span> $vm_scale_set_name</p>
    </div>
</body>
</html>
EOF"

# Restart Nginx to serve the new index page
sudo systemctl restart nginx