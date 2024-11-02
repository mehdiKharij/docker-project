# Stage 1: Builder stage
FROM php:8.3-cli AS builder

# Install dependencies for building
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip git curl libzip-dev libjpeg-dev libpng-dev libfreetype6-dev libicu-dev libxml2-dev

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install mysqli zip gd intl soap exif && \
    docker-php-ext-enable mysqli zip gd intl soap exif

# Clone the Moodle repository and check out the desired branch
RUN git clone git://git.moodle.org/moodle.git && \
    cd moodle && \
    git branch --track MOODLE_404_STABLE origin/MOODLE_404_STABLE && \
    git checkout MOODLE_404_STABLE

# Stage 2: Final stage
FROM php:8.3-apache

# Copy built PHP extensions and configurations from the builder stage
COPY --from=builder /usr/local/lib/php/ /usr/local/lib/php/
COPY --from=builder /usr/local/etc/php/ /usr/local/etc/php/

# Install only the necessary packages for runtime
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip curl libzip-dev libjpeg-dev libpng-dev libfreetype6-dev libicu-dev libxml2-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Moodle files from the builder stage
COPY --from=builder /moodle /var/www/html

# Set PHP configurations
RUN echo "max_input_vars=5000" >> /usr/local/etc/php/conf.d/docker-php-moodle.ini && \
    echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-moodle.ini

# Create the moodledata directory
RUN mkdir -p /var/www/moodledata

# Set correct permissions
RUN chown -R www-data:www-data /var/www/ && chmod -R 755 /var/www

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80