# Use the official PHP 8.3 image as a base
FROM php:8.3-apache

# Install necessary extensions and download/unzip template in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip wget git && \
    mkdir -p /tmp/webfiles && \
    cd /tmp/webfiles && \
    wget https://www.tooplate.com/zip-templates/2133_moso_interior.zip && \
    unzip 2133_moso_interior.zip && \
    cp -r 2133_moso_interior/* /var/www/html/ && \
    rm -rf /tmp/webfiles && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose port 80
EXPOSE 80
