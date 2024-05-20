{ pkgs, ... }: {
    home.packages = with pkgs; [
            # GUI
            kitty
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
        # NIX_SSL_CERT_FILE = "/Users/hendetp1/root-cert.cer";
    };

    programs.zsh.shellAliases.nixswitch = "darwin-rebuild switch --flake ~/flake.nix/.#slimDev";

}
