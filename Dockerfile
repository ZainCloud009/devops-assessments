# Stage 1: Build dependencies with Composer
FROM php:8.2-cli-alpine as builder

WORKDIR /var/www/html

# System dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip

# PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# App folder se composer files copy (Caching optimization)
COPY app/composer.json app/composer.lock* ./

RUN composer install --no-dev --optimize-autoloader --no-scripts

# Pura app source code copy karna
COPY app/ .

# Autoload finish karna after copying code
RUN composer dump-autoload --optimize

# Stage 2: Production Image with Apache
FROM php:8.2-apache

WORKDIR /var/www/html

# Install required PHP extensions for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Apache rewrite module enable karna Laravel routing ke liye
RUN a2enmod rewrite

# Apache DocumentRoot ko public folder par point karna
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/conf-available/*.conf

# Builder stage se code copy karna
COPY --from=builder /var/www/html /var/www/html

# Entrypoint script copy aur execute permission (agar entrypoint.sh root par hai)
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Permissions set karna (Standard Apache user www-data)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
