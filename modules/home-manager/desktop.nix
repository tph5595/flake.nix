{ config, lib, pkgs, ... }: 
{
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
                    wl-clipboard
                    # GUI Apps
                    foot
                    fuzzel
                    teams-for-linux
                    zoom-us
                    signal-desktop
                    # Does not work on wayland for now
                    kitty 
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

            home.file.".local/bin/status_bar.sh".source = ./scripts/status_bar.sh;
            home.file.".local/bin/cmus_song".source = ./scripts/cmus_song;
            home.file.".local/bin/createTask".source = ./scripts/createTask;
            home.file."Pictures/bg.png".source = ./Pictures/bg.png;

            home.file."./.config/foot" = {
                source = ./dotfiles/foot;
                recursive = true;
            };
            home.file."./.config/sway" = {
                source = ./dotfiles/sway;
                recursive = true;
            };
            home.file."./.config/hypr/" = {
                source = ./dotfiles/hypr;
                recursive = true;
            };
            home.file."./.config/waybar/" = {
                source = ./dotfiles/waybar;
                recursive = true;
            };
            home.file."./.config/fuzzel" = {
                source = ./dotfiles/fuzzel;
                recursive = true;
            };
        };
}
