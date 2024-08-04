{ config, lib, pkgs, ... }: 
{
    home.packages = with pkgs; [
        foot
        fuzzel
        wl-clipboard
    ];
    home.file."./.config/foot" = {
        source = ../config/foot;
        recursive = true;
    };
    home.file."./.config/sway" = {
        source = ../config/sway;
        recursive = true;
    };
    home.file."./.config/hypr/" = {
        source = ../config/hypr;
        recursive = true;
    };
    home.file."./.config/waybar/" = {
        source = ../config/waybar;
        recursive = true;
    };
    home.file."./.config/fuzzel" = {
        source = ../config/fuzzel;
        recursive = true;
    };

    home.file.".local/bin/status_bar.sh".source = ../bin/status_bar.sh;
    home.file.".local/bin/cmus_song".source = ../bin/cmus_song;
    home.file.".local/bin/createTask".source = ../bin/createTask;
}
