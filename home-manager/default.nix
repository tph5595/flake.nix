{ pkgs, ... }: 
{
    imports = [
        ./git.nix
        ./zsh.nix
        ./nvim.nix
        ./tmux.nix
        ./direnv.nix
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
            just
            ];
    home.sessionVariables = {
        CLICLOLOR = 1;
    };

    home.file."./.virtualenvs" = {
        source = ./dotfiles/.virtualenvs;
        recursive = true;
    };
}
