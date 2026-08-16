#!/bin/bash
echo "Pulling latest code from GitHub..."
git pull origin main

echo "Rebuilding Docker Container..."
docker build --no-cache -t my-laravel-app .
docker rm -f laravel_app
docker run -d --name laravel_app -e DB_HOST=172.31.5.23 -p 8080:80 my-laravel-app

echo "Clearing Laravel Cache..."
docker exec -it laravel_app php artisan optimize:clear

echo "Deployment Completed Successfully!"
