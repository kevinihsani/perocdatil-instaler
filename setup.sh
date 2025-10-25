#!/bin/bash

echo "🚀 Setting up Pterodactyl Panel in GitHub Codespace..."

# Install docker-compose jika belum ada
if ! command -v docker-compose &> /dev/null; then
    echo "📦 Installing docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Buat direktori yang diperlukan
echo "📁 Creating necessary directories..."
sudo mkdir -p /etc/pterodactyl
sudo mkdir -p /var/lib/pterodactyl
sudo mkdir -p /var/log/pterodactyl

# Set permissions
sudo chown -R 988:988 /etc/pterodactyl /var/lib/pterodactyl /var/log/pterodactyl

# Start services
echo "🐳 Starting Docker containers..."
docker-compose up -d

# Tunggu services ready
echo "⏳ Waiting for services to be ready..."
sleep 30

# Setup panel database
echo "🗃️ Setting up panel database..."
docker-compose exec panel php artisan key:generate --force
docker-compose exec panel php artisan migrate --force
docker-compose exec panel php artisan db:seed --force

echo "✅ Setup completed!"
echo ""
echo "🌐 Panel URL: https://${CODESPACE_NAME}-80.app.github.dev"
echo "🔧 Wings API: https://${CODESPACE_NAME}-8080.app.github.dev"
echo ""
echo "📝 Next steps:"
echo "   1. Run: docker-compose exec panel php artisan p:user:make"
echo "   2. Create your admin account"
echo "   3. Access the panel URL above to login"
