# Use the official PHP 8.3 image as a base
FROM php:8.3-apache

# Install necessary extensions, Apache mod_rewrite, and Composer
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip git curl php8.3-cli php8.3-common php8.3-curl php8.3-xml php8.3-mbstring libapache2-mod-php && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    git clone git://git.moodle.org/moodle.git && cd moodle && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cp -rf ./* /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80