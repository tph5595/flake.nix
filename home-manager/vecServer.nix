{ pkgs, lib, config, ... }: 

let nixGL = import ./modules/nixGL.nix { inherit pkgs config; };
in
{
    options.nixGLPrefix = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = ''
            Will be prepended to commands which require working OpenGL.

            This needs to be set to the right nixGL package on non-NixOS systems.
            '';
    };
        imports = [
            ./modules/kitty.nix
        ];
    config = {
        home.username = "taylor";
        home.homeDirectory = "/home/taylor";

        programs.home-manager.enable = true;

        home.packages = with pkgs; [
            pinentry
            (nixGL kitty)
        ];

        programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";
        programs.zsh.initExtra = ''
            . /home/$USER/.nix-profile/etc/profile.d/nix.sh
            '';

    };
}
