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



echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUJ31y39yyRgktmTa6Hp0tuNLrvB6OCRtWWgz3AJxRB minibox@home" >> "~/.ssh/authorized_keys"
