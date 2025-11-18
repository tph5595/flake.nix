{ pkgs, ... }: {
    imports = [
        ./modules/kitty.nix
    ];
    home.packages = with pkgs; [
        pinentry_mac
    ];
    home.homeDirectory = "/Users/hendetp1";
    home.sessionVariables = {
        BROWSER = "librewolf";
    };
}
