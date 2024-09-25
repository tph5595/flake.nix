{ pkgs, ... }: {
    imports = [
        ./modules/kitty.nix
    ];

    kitty.enable = true;

    home.packages = with pkgs; [
            # General
            ffmpeg_5-full
            terminal-notifier
            pinentry_mac
            # GUI
            openvpn
            darktable
            ];

    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#";
}
