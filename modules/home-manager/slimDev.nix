{ pkgs, ... }: {
    home.packages = with pkgs; [
            # GUI
            kitty
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#slimDev";

}
