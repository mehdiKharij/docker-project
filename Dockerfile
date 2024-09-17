# Base image
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Install necessary PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy composer.json
COPY composer.json ./

# Install PHP dependencies using Composer with no interaction
RUN apt-get update && apt-get install -y git unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader --no-suggest

# Copy the rest of the application files
COPY . .

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]