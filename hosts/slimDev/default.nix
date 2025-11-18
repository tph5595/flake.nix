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
        ssl-cert-file = /etc/ssl/certs/cacert-bundle.crt
        '';
    security.pki.certificateFiles = ["/etc/ssl/certs/cacert-bundle.crt"];
}
