{ config, lib, pkgs, ... }: 
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
        config = {
            home.username = "taylor";
            home.homeDirectory = "/home/taylor";

            programs.home-manager.enable = true;

            nixpkgs.config.allowUnfree = true;

            nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
            ];
            systemd.user.startServices = "sd-switch";

            home.packages = with pkgs; [
                    # General
                    glibc
                    # GUI Apps
                    foot
                    fuzzel
                    kitty
                    obsidian
                    openvpn
                    librewolf
                    (nixGL anki)
                    # Photo
                    darktable
                    # davinci-resolve
                    ffmpeg_5-full
                    # Gaming
                    (nixGL steam)
                    (nixGL discord)
                    # Music
                    vlc
                    tidal-hifi
                    (nixGL mixxx)
                    bitwig-studio
                    cmus
                    # Connections
                    dropbox
                    # Workout
                    # (nixGL golden-cheetah)
                    R
                    # https://github.com/nix-community/nixGL/issues/114
                    # https://discourse.nixos.org/t/fixing-error-attribute-currentsystem-missing-in-flake/22386/6
                    # nixgl.auto.nixGLNvidia
                    nixgl.nixGLIntel
                    ];
            # }
            # programs.golden-cheetah = {
                # enable = true;
                # package = (nixGL "${pkgs.golden-cheetah}/bin/GoldenCheetah");
            # };
            home.sessionVariables = {
                BROWSER = "librewolf";
            };

            programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";

            home.sessionVariables = {
                # QT_XCB_GL_INTEGRATION="none";
            };

            systemd.user.services.dropbox = {
                Unit = {
                    Description = "My dropbox service";
                };
                Install = {
                    WantedBy = [ "default.target" ];
                };
                Service = {
                    # Type = "exec";
                    ExecStart = "${pkgs.dropbox}/bin/dropbox";
                    # Restart = "on-failure";
                    # RestartSec = 2;
                };
            };
        home.file."./.config/foot" = {
            source = ./dotfiles/foot;
            recursive = true;
        };
        home.file."./.config/sway" = {
            source = ./dotfiles/sway;
            recursive = true;
        };
        home.file."./.config/fuzzel" = {
            source = ./dotfiles/fuzzel;
            recursive = true;
        };
    };
}
