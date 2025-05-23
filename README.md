# 🐘 Odoo 18 Multitenant Deployer

Spin up isolated Odoo 18 environments on a single server — each with its own database, port, systemd service, and HTTPS domain — all in seconds.

This tool automates multi-tenant deployment using:
- 🔧 Bash scripting  
- 🛠️ systemd for service isolation  
- 🌐 Caddy as a reverse proxy with auto HTTPS  

## 🚀 One-Step Setup (on a fresh server)

Run this command to install everything from GitHub:

```bash
curl -sSL https://raw.githubusercontent.com/RBTG-WebProduct/odoo18-multitenant-deployer/main/bootstrap-odoo18-deployer.sh | bash
```

run this command on a droplet running odoo17

```bash
curl -sSL https://raw.githubusercontent.com/RBTG-WebProduct/odoo18-multitenant-deployer/17.0/bootstrap-odoo17-deployer.sh | bash
```

## ⚙️ Create a New Odoo Instance

```bash
sudo create-odoo18-instance myclient
```

This will:
- Create a config at `/etc/odoo18-myclient.conf`  
- Assign a unique XML-RPC port  
- Set up a systemd service `odoo18-myclient`  
- Generate a reverse proxy config: `https://myclient.redbarn.club`  
- Start the instance and reload Caddy  

## 🧰 Manage All Instances

Use the built-in manager tool:

```bash
odoo18-manager status     # View all Odoo services
odoo18-manager restart    # Restart all instances
odoo18-manager stop       # Stop all
odoo18-manager start      # Start all
odoo18-manager list       # See what's running or not
```

Sample output:

```
🔍 Listing Odoo instances:
✅ odoo18-client1 is running
❌ odoo18-client2 is not running
```

## 🗂 Project Structure

```
odoo18-multitenant-deployer/
├── bootstrap-odoo18-deployer.sh        # One-step install script
├── scripts/
│   ├── create-odoo18-instance.sh       # Main deployment script
│   └── odoo18-manager                  # Manager script for all instances
├── templates/
│   ├── odoo18-template.conf            # Odoo config template
│   └── odoo18-template.service         # systemd unit template
├── caddy/
│   └── Caddyfile                       # Base Caddy config with import
└── README.md
```

## 🧱 How the System is Structured

After setup:

```
/opt/odoo18/
├── odoo18/              # Core Odoo code
├── odoo18-venv/         # Python environment
├── custom-addons/       # Your modules
├── design-themes/       # Theming packages

/etc/
├── odoo18-<dbname>.conf             # Per-tenant config
├── systemd/system/
│   └── odoo18-<dbname>.service      # Isolated systemd service
└── caddy/
    ├── Caddyfile                    # Main config
    └── sites/
        └── <dbname>.caddy           # Per-tenant reverse proxy
```

## 🧩 Requirements

- Ubuntu 20.04+ (or Debian-based)
- Caddy installed and running
- Odoo 18 set up under `/opt/odoo18/`
- DNS wildcard like `*.redbarn.club` → your server IP

## 🙌 Credits

Created with ❤️ by [@decodedal](https://github.com/decodedal)  
Project maintained by [RBTG-WebProduct](https://github.com/RBTG-WebProduct)

## 💡 Future Ideas

- [ ] `delete-odoo18-instance.sh` to remove tenants
- [ ] Add backup/export CLI
- [ ] Web UI for instance management

our golden url - /website/configurator