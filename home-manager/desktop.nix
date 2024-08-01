{ config, lib, pkgs, ... }: 
{
        imports = [
            ./conference.nix
            ./kitty.nix
            ./wayland_apps.nix
            ./dropbox.nix
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
                    ];

            home.sessionVariables = {
                BROWSER = "firefox";
            };

            programs.zsh.shellAliases.nixswitch = "sudo nixos-rebuild switch --flake ~/flake.nix/.#$HOST";

            home.file."Pictures/bg.png".source = ./Pictures/bg.png;
        };
}
