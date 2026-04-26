{ self, inputs, ... }: {

    flake.homeModules.ghostty = { pkgs, lib, ... }: {
        home.packages = with pkgs; 
            [ ghostty ];

        home.file.".config/ghostty/config" = {
            text = ''
                theme = Rose Pine
                background-opacity = 0.9

                font-family = Hack Regular Nerd Font Complete Mono
                font-size = 12
                cursor-style = block
                shell-integration-features = no-cursor

                confirm-close-surface = false

                quick-terminal-animation-duration = 0
                resize-overlay = never
            '';
        };
    };
}
