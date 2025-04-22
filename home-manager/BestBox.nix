{ pkgs, ... }: {
    imports = [
        ./modules/kitty.nix
    ];

    kitty.enable = true;

    home.packages = with pkgs; [
            # General
            ffmpeg_6-full
            terminal-notifier
            pinentry_mac
            # GUI
            openvpn
            darktable
            ];

    home.sessionVariables = {
        BROWSER = "librewolf";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#";
}
