{ pkgs, ... }: 

let 
    dvt = import ./scripts/dvt.nix { inherit pkgs; };
in 
{
    imports = [
        ./git.nix
        ./zsh.nix
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
            tmux
            ripgrep
            fd
            entr
            eza
            bat
            zsh-nix-shell
            nix-zsh-completions
            # Editor
            neovim
            # nvim deps
            taglib
            libxml2
            libxslt
            libzip
            zlib
            cacert 
            wget
            unzip
            # tree-sitter deps
            tree-sitter 
            nodejs 
            (lua5_1.withPackages (ps: with ps; [ luarocks ]))
            php83Packages.composer
            cargo
            rustc
            # My scripts
            dvt
            ];
    home.sessionVariables = {
        CLICLOLOR = 1;
        VISUAL = "nvim";
        EDITOR = "nvim";
    };

    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;

    programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
    };
    home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;
    home.file.".local/bin/tmux-sessionizer".source = ./scripts/tmux-sessionizer;

    home.file."./.config/nvim/" = {
        source = ./dotfiles/nvim;
        recursive = true;
    };
    home.file."./.config/kitty/" = {
        source = ./dotfiles/kitty;
        recursive = true;
    };
    home.file."./.virtualenvs" = {
        source = ./dotfiles/.virtualenvs;
        recursive = true;
    };
    home.file."./.config/tmux" = {
        source = ./dotfiles/tmux;
        recursive = true;
    };
}
