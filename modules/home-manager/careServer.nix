{ pkgs, ... }: {
    home.username = "thender8";
    home.homeDirectory = "/home/thender8";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            subversion
            glibc
            tshark
            ];
    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";
    programs.zsh.initExtra = ''
        . /home/thender8/.nix-profile/etc/profile.d/nix.sh
    '';

}
