{ config, pkgs, lib, ... }: 
{
    options = {
        ghostty.enable = 
            lib.mkEnableOption "enables ghostty";
        ghostty.font_size = 
            lib.mkOption {
                type = with lib.types; str;
                default = "12.0";
                description = "Font size for ghostty";
            };
    };
    config = lib.mkIf config.ghostty.enable {
        home.packages = with pkgs; 
        [ ghostty ];

        home.file."./.config/ghostty/config" = {
            text = ''
                theme = rose-pine
                background-opacity = 0.9

                font-family = Hack Regular Nerd Font Complete Mono
                font-size = ${config.ghostty.font_size}
                cursor-style = block
                shell-integration-features = no-cursor

                quick-terminal-animation-duration = 0
                resize-overlay = never
            '';
        };
    };
}
