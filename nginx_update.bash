#!/bin/bash

# Check the current deployment status (example: using a deployment_status.txt file)
deployment_status=$(cat deployment_status.txt)

# Set NGINX configuration directories
NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"

if [[ "$deployment_status" == "blue" ]]; then
    # Enable blue configuration and disable green configuration
    ln -sf "$NGINX_SITES_AVAILABLE/blue" "$NGINX_SITES_ENABLED/"
    rm -f "$NGINX_SITES_ENABLED/green"
elif [[ "$deployment_status" == "green" ]]; then
    # Enable green configuration and disable blue configuration
    ln -sf "$NGINX_SITES_AVAILABLE/green" "$NGINX_SITES_ENABLED/"
    rm -f "$NGINX_SITES_ENABLED/blue"
else
    echo "Unknown deployment status"
    exit 1
fi

# Reload NGINX
systemctl reload nginx

