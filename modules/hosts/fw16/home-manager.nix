{ self, inputs, ... }: {
    flake.nixosModules.taylorHome = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];
        home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.taylor = self.homeModules.baseHome;
        };
    };

    flake.homeModules.baseHome = { pkgs, ... }: {
        # Don't change this when you change package input. Leave it alone.
        home.stateVersion = "23.11";

        news.display = "silent";

        # programs.home-manager.enable = true;

        home.packages = with pkgs; [
            # Nix utils
            nix-output-monitor
                expect
                # General
                glances
                htop
                btop
                zenith
                ripgrep
                fd
                entr
                eza
                bat
                just
                zstd
                delta
                # bluetui not supported on mac
        ];

        home.sessionVariables = {
            CLICLOLOR = 1;
        };
        home.file."./.config/glances/glances.conf" = {
            text = ''
                [global]
                check_update=false
                    '';
        };
    };
}
