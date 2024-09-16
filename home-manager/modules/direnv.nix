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
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
    };
}
