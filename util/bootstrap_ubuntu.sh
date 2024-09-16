#!/bin/bash
set -e

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable flakes
mkdir -p ~/.config/nix/
cat > ~/.config/nix/nix.conf << EOF
experimental-features = nix-command flakes
EOF

# For single user install
export PATH=$PATH:~/.nix-profile/bin

nix run nixpkgs#home-manager -- switch --flake .#$(hostname)

sudo chsh $USER -s ~/.nix-profile/bin/zsh
