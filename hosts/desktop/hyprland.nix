{ config, pkgs, lib, ... }:
{

  programs.hyprland = {    
      enable = true;    
      xwayland.enable = true;    
  };
  programs.waybar.enable = true;
  services.xserver.displayManager.gdm.wayland = true;  
}
