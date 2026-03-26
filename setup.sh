#!/bin/bash

set -e
echo "[1/6] Updating system..."
sudo apt update -y
sudo apt install -y openssh-server
echo "[3/6] Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo "[4/6] Setting up SSH key..."
USER_HOME=$(eval echo ~${SUDO_USER:-$USER})

mkdir -p "$USER_HOME/.ssh"
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUJ31y39yyRgktmTa6Hp0tuNLrvB6OCRtWWgz3AJxRB minibox@home" >> "$USER_HOME/.ssh/authorized_keys"

chmod 700 "$USER_HOME/.ssh"
chmod 600 "$USER_HOME/.ssh/authorized_keys"
chown -R ${SUDO_USER:-$USER}:${SUDO_USER:-$USER} "$USER_HOME/.ssh"

echo "[5/6] Hardening SSH..."
sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

echo "[6/6] Restarting SSH..."
sudo systemctl restart ssh

echo "✅ Done! You can now SSH into the server."


usermod -aG sudo mrwhite


sudo mkdir -p "/home/mrwhite/.ssh/authorized_keys"
sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUJ31y39yyRgktmTa6Hp0tuNLrvB6OCRtWWgz3AJxRB minibox@home" >> "/home/mrwhite/.ssh/authorized_keys"



sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config


sudo apt update
sudo apt install -y curl

curl -fsSL https://pkg.cloudflare.com/install.sh | sudo bash
sudo apt install cloudflared


wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

sudo dpkg -i cloudflared-linux-amd64.deb

cloudflared tunnel login
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared


sudo cloudflared service install eyJhIjoiOGJlMjA4YWY2MGM3MTA3YTkwYTBmZDNhNGJmNTljMDIiLCJ0IjoiOTEwZjI1YzMtZjg1NS00Y2E3LTlmYmEtODg2NDdjNTUyZWZhIiwicyI6IlpEWXhNRFF5WTJFdE1UTXhPQzAwWW1ZeUxUZ3hNMk10WkRFME16UmpZelE0TVRJNSJ9


