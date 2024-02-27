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
  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
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
                          users.taylor.imports = [ ./modules/home-manager ];
                      };
                  }
          ];
      };
  };
}
