#!/bin/bash

# Install Nginx server

echo "Installing Nginx..."

sudo apt update
sudo apt install nginx
sudo systemctl start nginx

if [[ $? -ne 0 ]]
then
    echo "Nginx could not be installed."
    exit 1
fi

sudo ufw allow ssh

if [[ "${?}" -ne 0 ]]
then
    echo "Could not configure firewall. Current UFW status:"
    sudo ufw status
    exit 1
fi

sudo ufw allow "Nginx Full"

if [[ "${?}" -ne 0 ]]
then
    echo "Could not configure firewall. Current UFW status:"
    sudo ufw status
    exit 1
fi

sudo ufw enable 

# Remove old server block and symlink...
sudo rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
if [[ $? -ne 0 ]]
then
    echo "Could not remove old server bloc."
    exit 1
fi

# Test config...
sudo nginx -t 

if [[ $? -ne 0 ]]
then
    echo "Nginx was not properly configured."
    exit 1
fi


sudo touch /etc/nginx/sites-available/my_domain
sudo cat <<EOT > /etc/nginx/sites-available/my_domain
server {
    listen 80;
    listen [::]:80;

    server_name my_domain;

    location / {
        proxy_pass http://localhost:3000;
        include proxy_params;
    }
}
sudo cat 
EOT

sudo ln -sf /etc/nginx/sites-available/my_domain /etc/nginx/sites-enabled/my_domain

# Reload settings
sudo systemctl reload nginx

echo "Nginx successfully configured, reverse proxying HTTP traffic to Port 3000."
rm "${0}"
