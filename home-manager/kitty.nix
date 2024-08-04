{ pkgs, ... }: 
{
    home.packages = with pkgs; [
        kitty
    ];
    home.file."./.config/kitty/" = {
        source = ../config/kitty;
        recursive = true;
    };
}
