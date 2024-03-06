{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            kitty
            ffmpeg_5-full
            nmap
            openvpn
            subversion
            darktable
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";
}
