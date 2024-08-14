#!/bin/bash
set -e

export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable flakes
mkdir -p ~/.config/nix/
cat > ~/.config/nix/nix.conf << EOF
experimental-features = nix-command flakes
EOF

# For mac
# nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.BestBox.system
# ./result/sw/bin/darwin-rebuild switch --flake .#BestBox

# For single user install
export PATH=$PATH:~/.nix-profile/bin
# Silly VScode 
rm /home/jovyan/.local/share/code-server/code-server-ipc.sock
export USER=jovyan
unset LC_ALL

# Add to .bashrc
cat >> ~/.bashrc << EOF
. /home/jovyan/.nix-profile/etc/profile.d/nix.sh
export PATH=$PATH:~/.nix-profile/bin
export USER=jovyan
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
unset LC_ALL
zsh
exit
EOF

nix run nixpkgs#home-manager -- switch --flake .#superSkinny

sudo apt update && sudo apt install -y python3.10-venv

sudo chsh $USER -s ~/.nix-profile/bin/zsh
