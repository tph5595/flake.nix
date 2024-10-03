{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hyprland.nix
      ./sway.nix
      ./docker.nix
      ./vm.nix
      ./clamav.nix
      ./lookingglass.nix
    ];
}
