{ pkgs, ... }: {
    home.username = "thender8";
    home.homeDirectory = "/home/thender8";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            subversion
            htop
            glibc
            ];
    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";

}
