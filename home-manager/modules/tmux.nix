{ pkgs, lib, config, ... }: 
{
    home.packages = with pkgs; [
        tmux
    ];
    home.file."./.config/tmux" = {
        source = ../../config/tmux;
        recursive = true;
    };
    home.file.".local/bin/tmux-sessionizer".source = ../../bin/tmux-sessionizer;
}
