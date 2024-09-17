# Use PHP 8.3 with Apache
FROM php:8.3-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Copy application files to the container
COPY . /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Install composer and dependencies
COPY composer.json composer.lock ./
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install