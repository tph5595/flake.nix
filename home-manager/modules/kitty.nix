{ config, pkgs, lib, ... }: 
let nixGL = import ./nixGL.nix { inherit pkgs config; };
in
{
    options.nixGLPrefix = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = ''
            Will be prepended to commands which require working OpenGL.

            This needs to be set to the right nixGL package on non-NixOS systems.
            '';
    };
    options = {
        kitty.enable = 
            lib.mkEnableOption "enables kitty";
        kitty.nixGL = 
            lib.mkEnableOption "enables nixGL for kitty";
        kitty.hide_borders = 
            lib.mkOption {
                type = with lib.types; str;
                default = "yes";
                description = "Whether to show window borders";
            };
        kitty.font_size = 
            lib.mkOption {
                type = with lib.types; str;
                default = "18.0";
                description = "Font size for kitty";
            };
    };
    config = lib.mkIf config.kitty.enable {
        home.packages = with pkgs; 
        [ ] ++ (if config.kitty.nixGL then
            [ (nixGL kitty)]
          else [
            kitty
          ]);
        home.file."./.config/kitty/rose-pine.conf" = {
            source = ../../config/kitty/rose-pine.conf;
        };
        home.file."./.config/kitty/kitty.conf" = {
            text = ''
                include rose-pine.conf

                #Font-Family
                font_family Hack Regular Nerd Font Complete Mono
                italic_font auto
                bold_font auto
                bold_italic_font auto

                hide_window_decorations ${config.kitty.hide_borders}

                #Font size (in pts)
                font_size ${config.kitty.font_size}

                #Foreground color
                # foreground #ffffff

                #Background color
                # background #7d2ac9
            '';
        };
        };
    }
