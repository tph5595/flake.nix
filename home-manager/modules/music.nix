{ pkgs, lib, config, pkgs-unstable, ... }:
{
    home.packages = with pkgs; [
        # HW Interface controls
        alsa-scarlett-gui

        # DJ
        # mixxx

        # DAW
        bitwig-studio4
    ];
}
