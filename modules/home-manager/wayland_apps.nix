{ config, lib, pkgs, ... }: 
{
    home.packages = with pkgs; [
        foot
        fuzzel
        wl-clipboard
    ];
    home.file."./.config/foot" = {
        source = ./dotfiles/foot;
        recursive = true;
    };
    home.file."./.config/sway" = {
        source = ./dotfiles/sway;
        recursive = true;
    };
    home.file."./.config/hypr/" = {
        source = ./dotfiles/hypr;
        recursive = true;
    };
    home.file."./.config/waybar/" = {
        source = ./dotfiles/waybar;
        recursive = true;
    };
    home.file."./.config/fuzzel" = {
        source = ./dotfiles/fuzzel;
        recursive = true;
    };

    home.file.".local/bin/status_bar.sh".source = ./scripts/status_bar.sh;
    home.file.".local/bin/cmus_song".source = ./scripts/cmus_song;
    home.file.".local/bin/createTask".source = ./scripts/createTask;
}
