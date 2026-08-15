#!/bin/bash
set -e

echo "Waiting for database connection..."

# Database ready hone tak retry karein (max 30 seconds)
max_tries=15
count=0
until php artisan db:monitor > /dev/null 2>&1 || [ $count -eq $max_tries ]; do
    echo "Database to be reachable... ($count/$max_tries)"
    sleep 2
    count=$((count+1))
done

# Config aur View cache
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Running migrations..."
php artisan migrate --force

echo "Starting Apache..."
exec apache2-foreground
