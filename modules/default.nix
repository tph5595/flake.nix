{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./dropbox.nix
      ./hyprland.nix
      ./sway.nix
      ./docker.nix
      ./vm.nix
    ];
}
