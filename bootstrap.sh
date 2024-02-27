#!/bin/sh
# sh <(curl -L https://nixos.org/nix/install) --daemon
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.BestBox.system
./result/sw/bin/darwin-rebuild switch --flake .#BestBox
