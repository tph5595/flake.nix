{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./dropbox.nix
      ./hyprland.nix
      ./sway.nix
    ];
}
