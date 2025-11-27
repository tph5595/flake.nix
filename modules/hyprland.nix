{ config, pkgs, lib, ... }:
{

  programs.hyprland = {    
      enable = true;    
      xwayland.enable = true;    
  };
  programs.waybar.enable = true;
  services.displayManager.gdm.wayland = true;  

  security.pam.services.hyprlock = {};
}
