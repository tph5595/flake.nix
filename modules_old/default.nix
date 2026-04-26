{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hyprland.nix
      ./sway.nix
      ./docker.nix
      ./vm.nix
      ./k3s.nix
      ./clamav.nix
      ./lookingglass.nix
    ];
}
