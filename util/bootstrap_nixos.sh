set -e

# Enable flakes
mkdir -p ~/.config/nix/
cat > ~/.config/nix/nix.conf << EOF
experimental-features = nix-command flakes
EOF

# Save base config
mkdir hosts/$(hostname)
pushd hosts/$(hostname)
cp /etc/nixos/* .
cp configuration.nix default.nix
nix-shell -p ormolu --command "git add *"
popd

sudo nixos-rebuild switch --flake ~/flake.nix#$(hostname)
