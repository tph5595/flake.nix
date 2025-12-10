{ pkgs, ... }: {
    imports = [
        ./modules/kitty.nix
    ];
    home.packages = with pkgs; [
        pinentry_mac
    ];
    home.homeDirectory = "/Users/hendetp1";
    home.sessionVariables = {
        BROWSER = "firefox";
    };
    home.uid = 501;
    ghostty.enable = false;
    programs.zsh.shellAliases.nixswitch = "sudo darwin-rebuild switch --flake ~/flake.nix/.#LV72G447MG-ML";
}
