{ pkgs, ... }: {
    imports = [
        ../../darwin
    ];

    darwin = { 
        enable = true;
        user = "hendetp1";
        touch-id = true;
    };

    nix.extraOptions = ''
        ssl-cert-file = /Users/hendetp1/root-cert.cer
        '';
    security.pki.certificateFiles = ["/Users/hendetp1/root-cert.cer"];
}
