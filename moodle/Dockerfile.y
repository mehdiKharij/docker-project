# Use the official PHP 8.3 image as a base
FROM php:8.3-apache

# Install necessary extensions, Apache mod_rewrite, and Composer
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip git curl && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    git clone git://git.moodle.org/moodle.git && cd moodle && \
    git branch --track MOODLE_404_STABLE origin/MOODLE_404_STABLE && \
    git checkout MOODLE_404_STABLE && \
    cp -rf ./* /var/www/html/

RUN mkdir -p /var/www/moodledata

# Set working directory
WORKDIR /var/www/html

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/ && chmod -R 755 /var/www

# Expose port 80
EXPOSE 80