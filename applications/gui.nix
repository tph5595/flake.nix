{ config, lib, pkgs, ... }:

let
  nixGL = import ./nixGL.nix { inherit pkgs config; };
in {

  options.nixGLPrefix = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      Will be prepended to commands which require working OpenGL.

      This needs to be set to the right nixGL package on non-NixOS systems.
    '';
  };

    # Graphical applications
    home.packages = with pkgs;
      [
        # Messaging apps
        (nixGL (discord.override {
          nss = nss_latest; # https://github.com/NixOS/nixpkgs/issues/78961
        }))

        (nixGL spotify)
        (nixGL mixxx)
      ];
}
