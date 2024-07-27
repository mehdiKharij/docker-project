# Use the official PHP 8.3 image as a base
FROM php:8.3-apache

# Install necessary extensions
RUN apt update && apt install -y unzip wget git

# Creating Temp Directory
RUN mkdir -p /tmp/webfiles && cd /tmp/webfiles
RUN wget https://www.tooplate.com/zip-templates/2133_moso_interior.zip
RUN unzip 2133_moso_interior.zip
RUN cp -r 2133_moso_interior/* /var/www/html/
RUN cd ~

# Clean Up
RUN rm -rf /tmp/webfiles

# Expose port 80
EXPOSE 80