{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            pinentry
            ];
    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";
    programs.zsh.initExtra = ''
        . /home/$USER/.nix-profile/etc/profile.d/nix.sh
    '';

}
