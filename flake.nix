{
  description = "Taylor's Nix configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, ... }: {

      darwinConfigurations.BestBox = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          pkgs = import nixpkgs { system = "x86_64-darwin"; };
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
          ];
      };

      # https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
      homeConfigurations = {
          pop-os = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages."x86_64-linux";
              modules = [
                  ./modules/home-manager
                  ./modules/home-manager/pop.nix
              ];
          };
      };

      templates = {
          python = {
              path = ./templates/dev/python;
              description = "Python dev environment template";
          };

          rust = {
              path = ./templates/dev/rust;
              description = "Rust dev environment template";
          };
          bash = {
              path = ./templates/default;
              description = "nix flake new -t github:Mic92/nix-direnv .";
          };
          latex = {
              path = ./templates/dev/latex;
              description = "Latex dev environment template";
          };
      };
      defaultTemplate = self.templates.bash;
  };
}
