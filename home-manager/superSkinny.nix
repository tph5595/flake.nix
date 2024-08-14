{ pkgs, ... }: {
    home.username = "joyvan";
    home.homeDirectory = "/home/joyvan";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            ];
    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#superSkinny";
    programs.zsh.initExtra = ''
        . /home/joyvan/.nix-profile/etc/profile.d/nix.sh
    '';

}
