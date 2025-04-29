{ config, lib, pkgs, pkgs-python, ... }: 
{
        imports = [
            ./modules/conference.nix
            ./modules/kitty.nix
            ./modules/wayland_apps.nix
            ./modules/dropbox.nix
        ];

        config = {
            home.username = "taylor";
            home.homeDirectory = "/home/taylor";

            programs.home-manager.enable = true;
            programs.autorandr.enable = true;

            nixpkgs.config.allowUnfree = true;

            nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
                "golden-cheetah-3.6"
            ];
            systemd.user.startServices = "sd-switch";

            home.packages = with pkgs; [
                    # General
                    glibc
                    zig
                    # GUI Apps
                    obsidian
                    openvpn
                    anki
                    firefox-wayland
                    librewolf
                    pavucontrol # audio control gui
                    qalculate-qt
                    thunderbird
                    # Photo
                    darktable
                    # davinci-resolve
                    ffmpeg_6-full
                    feh
                    # Gaming
                    steam
                    discord
                    # Music
                    vlc
                    # tidal-hifi
                    # mixxx
                    # bitwig-studio
                    cmus
                    # Workout
                    golden-cheetah-bin
                    appimage-run
                    R
                    # rstudioWrapper.override{ 
                    #     packages = with rPackages; [ 
                    #         ggplot2 dplyr xts 
                    #     ]; 
                    # }
                    pinentry
                    # gui network manager
                    networkmanagerapplet
                    # ebook manager
                    calibre
                    # Chess
                    en-croissant
                    # GPU monitor
                    # nvtopPackages.full
                    ] ++ [
                    (pkgs-python.packages.x86_64-linux."3.7.17".withPackages 
                    (ps: with ps; [
                        # pip
                        # pandas
                    ]))
                    ];

            home.sessionVariables = {
                BROWSER = "librewolf";
            };

            programs.zsh.shellAliases.nixswitch = "sudo nixos-rebuild switch --flake ~/flake.nix/.#$HOST";

            home.file."Pictures/bg.png".source = ./Pictures/bg.png;
        };
}
