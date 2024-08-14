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
# rm /home/jovyan/.local/share/code-server/code-server-ipc.sock
# For other linux
# How is this not set
# export USER=jovyan
# HOW?!
# unset LC_ALL
# NOT BELOW?
# apt-get clean && apt-get update
# apt-get install locales
# locale-gen en_US.UTF-8

nix run nixpkgs#home-manager -- switch --flake .#superSkinny

sudo chsh $USER -s .nix-profile/bin/zsh
