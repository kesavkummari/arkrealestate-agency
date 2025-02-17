#!/bin/bash
# Update package repository
sudo apt update -y

# Install Apache
sudo apt install apache2 -y

# Start and enable Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

# Create a sample index.html file
echo "<h1>Welcome to My Terraform-Provisioned EC2 Instance</h1>" | sudo tee /var/www/html/index.html

# Install other dependencies if needed
sudo apt install -y curl unzip

# Log script execution
echo "Provisioning complete" >> /var/log/user_data.log
