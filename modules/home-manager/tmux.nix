{ pkgs, lib, config, ... }: 
{
    home.packages = with pkgs; [
        tmux
    ];
    home.file."./.config/tmux" = {
        source = ./dotfiles/tmux;
        recursive = true;
    };
    home.file.".local/bin/tmux-sessionizer".source = ./scripts/tmux-sessionizer;
}
