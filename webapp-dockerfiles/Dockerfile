# Use the official PHP 8.3 image as a base
FROM php:8.3-apache

# Install necessary extensions
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Copy application files to the container
COPY . /var/www/html/

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Install Composer
RUN apt-get update && apt-get install -y unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install AWS SDK for PHP
RUN cd /var/www/html && composer require aws/aws-sdk-php

# Expose port 80
EXPOSE 80