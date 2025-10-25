#!/bin/bash

echo "👤 Creating Pterodactyl Admin Account..."
echo "Follow the prompts below:"

docker-compose exec panel php artisan p:user:make

echo ""
echo "✅ Admin account created!"
echo "🌐 Login at: https://${CODESPACE_NAME}-80.app.github.dev"
