#!/bin/bash
set -e

# Cache configuration, routes, and views
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run database migrations automatically
cd /var/www/html/devops-assesments/app/
php artisan migrate --force

# Start Apache in foreground
exec apache2-foreground
