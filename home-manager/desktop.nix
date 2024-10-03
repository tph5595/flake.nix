{ config, lib, pkgs, ... }: 
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

            nixpkgs.config.allowUnfree = true;

            nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
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
                    # Photo
                    darktable
                    davinci-resolve
                    ffmpeg_5-full
                    feh
                    # Gaming
                    steam
                    discord
                    # Music
                    vlc
                    tidal-hifi
                    mixxx
                    bitwig-studio
                    cmus
                    # Workout
                    # golden-cheetah
                    appimage-run
                    R
                    pinentry
                    # gui network manager
                    networkmanagerapplet
                    ];

            home.sessionVariables = {
                BROWSER = "firefox";
            };

            programs.zsh.shellAliases.nixswitch = "sudo nixos-rebuild switch --flake ~/flake.nix/.#$HOST";

            home.file."Pictures/bg.png".source = ./Pictures/bg.png;
        };
}
