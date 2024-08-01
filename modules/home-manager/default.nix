{ pkgs, ... }: 

let 
    dvt = import ./scripts/dvt.nix { inherit pkgs; };
in 
{
    imports = [
        ./git.nix
        ./zsh.nix
        ./nvim.nix
        ./tmux.nix
    ];
    # Don't change this when you change package input. Leave it alone.
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            # Nix utils
            nix-output-monitor
            expect
            # General
            glances
            htop
            zenith
            ripgrep
            fd
            entr
            eza
            bat
            # My scripts
            dvt
            ];
    home.sessionVariables = {
        CLICLOLOR = 1;
    };

    programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
    };
    home.file."./.config/kitty/" = {
        source = ./dotfiles/kitty;
        recursive = true;
    };
    home.file."./.virtualenvs" = {
        source = ./dotfiles/.virtualenvs;
        recursive = true;
    };
}
