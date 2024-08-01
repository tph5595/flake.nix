{ pkgs, ... }: {
    imports = [
        ./kitty.nix
    ];
    home.packages = with pkgs; [
        pinentry_mac
    ];
    home.sessionVariables = {
        BROWSER = "firefox";
        # NIX_SSL_CERT_FILE = "/Users/hendetp1/root-cert.cer";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#slimDev";
}
