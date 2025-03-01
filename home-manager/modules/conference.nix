{ pkgs, lib, config, pkgs-unstable, ... }:
{
    nixpkgs.overlays = [
        (self: super: {
         zoom-us = pkgs-unstable.zoom-us;
         })
    ];
    home.packages = with pkgs; [
        teams-for-linux
        zoom-us
    ];
}
