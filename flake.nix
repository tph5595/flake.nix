{
  description = "Taylor's Nix configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/release-24.05";
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
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, darwin, agenix, nixGL, ... }: rec {
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

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ 
              ./hosts/desktop
              agenix.nixosModules.age
              home-manager.nixosModules.home-manager
              {
                  home-manager.useGlobalPkgs = false;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = {
                      pkgs-unstable = import nixpkgs-unstable {
                          inherit system;
                          config.allowUnfree = true;
                      };
                  };
                  home-manager.users.taylor.imports = [
                      ./home-manager
                      ./home-manager/desktop.nix
                  ];
              }
              {
                  environment.systemPackages = [ agenix.packages.${system}.default ];
              }
          ];
      };
      darwinConfigurations.BestBox = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
              ./hosts/BestBox
                  home-manager.darwinModules.home-manager
                  {
                      home-manager = {
                          useGlobalPkgs = true;
                          useUserPackages = true;
                          users.taylor.imports = [ 
                              ./home-manager 
                              ./home-manager/BestBox.nix
                          ];
                      };
                  }
              agenix.darwinModules.age
              ./secrets/darwin.nix
              {
                  environment.systemPackages = [ agenix.packages.${system}.default ];
              }
          ];
      };
      darwinConfigurations.slimDev = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
              ./hosts/slimDev
                  home-manager.darwinModules.home-manager
                  {
                      home-manager = {
                          useGlobalPkgs = true;
                          useUserPackages = true;
                          users.hendetp1.imports = [ 
                              ./home-manager 
                              ./home-manager/slimDev.nix
                          ];
                      };
                  }
          ];
      };

      # https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
      homeConfigurations = {
          pop-os = home-manager.lib.homeManagerConfiguration {
              pkgs = legacyPackages.x86_64-linux;
              modules = [
                  ./home-manager
                  ./home-manager/pop.nix
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
                  ./home-manager
                  ./home-manager/careServer.nix
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
                  ./home-manager
                      ./home-manager/careServer.nix
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
                  ./home-manager
                      ./home-manager/careServer.nix
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
