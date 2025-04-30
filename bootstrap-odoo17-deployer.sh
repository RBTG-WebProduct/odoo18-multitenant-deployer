#!/bin/bash
set -e

REPO_URL="https://github.com/RBTG-WebProduct/odoo17-multitenant-deployer"
CLONE_DIR="/tmp/odoo17-deployer"

echo "📥 Cloning deployer repo..."
rm -rf "$CLONE_DIR"
git clone "$REPO_URL" "$CLONE_DIR"

echo "🚀 Installing odoo17-multitenant-deployer..."

# 1. Install main instance creation script
sudo install -m 755 "$CLONE_DIR/scripts/create-odoo17-instance.sh" /usr/local/bin/create-odoo17-instance

# 2. Install instance manager
sudo install -m 755 "$CLONE_DIR/scripts/odoo17-manager.sh" /usr/local/bin/odoo17-manager

# 3. Install config and systemd templates
sudo mkdir -p /usr/local/share/odoo17-templates/
sudo cp "$CLONE_DIR/templates/"*.conf /usr/local/share/odoo17-templates/
sudo cp "$CLONE_DIR/templates/"*.service /usr/local/share/odoo17-templates/
echo "✅ Templates installed"

# 4. Caddy setup
sudo mkdir -p /etc/caddy/sites/
if [ ! -f /etc/caddy/Caddyfile ]; then
    sudo cp "$CLONE_DIR/caddy/Caddyfile" /etc/caddy/Caddyfile
    echo "✅ Default Caddyfile installed"
fi

IMPORT_LINE="import sites/*.caddy"
if ! grep -qF "$IMPORT_LINE" /etc/caddy/Caddyfile; then
    echo "$IMPORT_LINE" | sudo tee -a /etc/caddy/Caddyfile > /dev/null
    echo "✅ Added 'import sites/*.caddy' to Caddyfile"
fi

#5. install deletion script 

# 3. Install deletion script
sudo install -m 755 "$CLONE_DIR/scripts/delete-odoo17-instance.sh" /usr/local/bin/delete-odoo17-instance
echo "🗑️  Delete script installed"


echo ""
echo "🎉 Setup complete! Now you can run:"
echo "   sudo create-odoo17-instance <yourdbname>"
echo "   odoo17-manager status"
echo ""
