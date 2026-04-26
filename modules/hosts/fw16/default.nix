{ self, inputs, ... }: {
  flake.nixosConfigurations.fw16 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.fw16Configuration
    ];
  };
}
