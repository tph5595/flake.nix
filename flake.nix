{
  description = "Taylor's Nix configuration";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls MacOS system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Share secrets 
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, agenix, nixGL, ... }: rec {
      legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ]
      (system:
        import inputs.nixpkgs {
          inherit system;

          # NOTE: Using `nixpkgs.config` in your NixOS config won't work
          # Instead, you should set nixpkgs configs here
          # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)
          config.allowUnfree = true;
          overlays = [ nixGL.overlay ];
        });

      darwinConfigurations.BestBox = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
              ./modules/darwin
              home-manager.darwinModules.home-manager
              {
                  home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.taylor.imports = [ 
                          ./modules/home-manager 
                          ./modules/home-manager/BestBox.nix
                      ];
                  };
              }
              agenix.darwinModules.age
              ./secrets/darwin.nix
              {
                  environment.systemPackages = [ agenix.packages."x86_64-darwin".default ];
              }
          ];
      };

      # https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
      homeConfigurations = {
          pop-os = home-manager.lib.homeManagerConfiguration {
              pkgs = legacyPackages.x86_64-linux;
              modules = [
                  ./modules/home-manager
                  ./modules/home-manager/pop.nix
                  agenix.homeManagerModules.age
                  ./secrets/pop.nix
                  {
                    home.packages = [
                        agenix.packages."x86_64-linux".default
                    ];
                  }
                  ({ ... }: {
                   nixGLPrefix =
                       # "${legacyPackages.x86_64-linux.nixgl.auto.nixGLNvidia}/bin/nixGLNvidia-550.67 ";
                       "${legacyPackages.x86_64-linux.nixgl.nixGLIntel}/bin/nixGLIntel ";
                   })
              ];
          };
          sr3s13 = home-manager.lib.homeManagerConfiguration {
              pkgs = legacyPackages.x86_64-linux;
              modules = [
                  ./modules/home-manager
                  ./modules/home-manager/careServer.nix
                  agenix.homeManagerModules.age
                  ./secrets/care.nix
                  {
                    home.packages = [
                        agenix.packages."x86_64-linux".default
                    ];
                  }
              ];
          };
          sr4s5 = home-manager.lib.homeManagerConfiguration {
              pkgs = legacyPackages.x86_64-linux;
              modules = [
                  ./modules/home-manager
                      ./modules/home-manager/careServer.nix
                      agenix.homeManagerModules.age
                      ./secrets/care.nix
                      {
                          home.packages = [
                              agenix.packages."x86_64-linux".default
                          ];
                      }
              ];
          };
          sr3s10 = home-manager.lib.homeManagerConfiguration {
              pkgs = legacyPackages.x86_64-linux;
              modules = [
                  ./modules/home-manager
                      ./modules/home-manager/careServer.nix
                      agenix.homeManagerModules.age
                      ./secrets/care.nix
                      {
                          home.packages = [
                              agenix.packages."x86_64-linux".default
                          ];
                      }
              ];
          };
      };

      templates = {
        full = {
          path = ./.;
          description = "Full env setup";
        };
      } // import ./templates;
      defaultTemplate = self.templates.full;
  };
}
