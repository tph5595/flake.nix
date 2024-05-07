#!/bin/sh
set -e

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable flakes
mkdir -p ~/.config/nix/
cat > ~/.config/nix/nix.conf << EOF
experimental-features = nix-command flakes
EOF

# For mac
# nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.BestBox.system
# ./result/sw/bin/darwin-rebuild switch --flake .#BestBox

# For other linux
nix run nixpkgs#home-manager -- switch --flake .#$HOST

sudo chsh $USER -s .nix-profile/bin/zsh
