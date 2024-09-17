{ pkgs, ... }: {
    imports = [
        ./modules/kitty.nix
    ];
    home.packages = with pkgs; [
        pinentry_mac
    ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#slimDev";
}
