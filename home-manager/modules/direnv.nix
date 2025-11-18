{ pkgs, ... }: 

let 
    dvt = import ../../bin/dvt.nix { inherit pkgs; };
in 
{
    home.packages = with pkgs; [
        dvt
    ];

    programs = {
        direnv = {
          enable = false;
          enableZshIntegration = false;
          nix-direnv.enable = false;
        };
    };
}
