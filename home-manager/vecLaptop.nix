{ pkgs, lib, config, ... }: 
{
    imports = [
        ./modules/kitty.nix
    ];

    kitty = {
        enable = true;
        font_size = "16.0";
        hide_borders = "no";
        nixGL = true;
    };

    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        pinentry
        xclip
    ];

    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";
    programs.zsh.shellAliases.vecVPN = "sudo openvpn ~/Documents/VPN/vectare.ovpn";
    programs.zsh.initExtra = ''
        . /home/$USER/.nix-profile/etc/profile.d/nix.sh
        '';
}
