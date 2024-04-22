{ pkgs, ... }: {
    # Don't change this when you change package input. Leave it alone.
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
            tshark
            cabal-install 
            ripgrep
            fd
            neovim
            nodejs 
            taglib
            libxml2
            libxslt
            libzip
            zlib
            cacert 
            tree-sitter 
            dvc
            entr
            glances
            htop
            zenith
            tmux
            luajitPackages.luarocks
            php83Packages.composer
            julia_18-bin
            pinentry
            eza
            bat
            zsh-nix-shell
            nix-zsh-completions
            ];
    home.sessionVariables = {
        CLICLOLOR = 1;
        VISUAL = "nvim";
        EDITOR = "$VISUAL";
    };

    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;

    programs.git.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = false;
        syntaxHighlighting.enable = true;
        autocd = false;
        initExtraFirst = ''
            # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
            # Initialization code that may require console input (password prompts, [y/n]
            # confirmations, etc.) must go above this block; everything else may go below.
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
        '';
        initExtra = ''
            # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

            zstyle ':completion:*' menu select
            zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} "ma=48;5;244;1"
            zstyle ':completion:*' matcher-list ''\'' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
            '';
        envExtra = ''
        . "$HOME/.cargo/env"
        '';
        zplug = {
            enable = true;
            plugins = [
            { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
            { name = "supercrabtree/k"; tags = ["depth:1"]; }
            { name = "plugins/git"; tags = ["from:oh-my-zsh"]; }
            { name = "jeffreytse/zsh-vi-mode"; tags = ["depth:1"]; }
            { name ="zsh-users/zsh-syntax-highlighting"; tags = ["defer:2"]; }
            ];
        };
        shellAliases = {
            upug = "pushd ~/flake.nix; nix flake update; nixswitch; popd";
            ls = "ls --color=auto";
            l = "ls -lah";
            c = "clear";
            cl = "c && ls";
            ga = "git add";
            gc = "git commit";
            gs = "git status";
            gps = "git push";
            gpl = "git pull";
            revealjs = "pandoc -t revealjs -s --mathjax -i --variable transition=none --variable controls=false --variable controlsTutorial=false --variable slideNumber=true --variable fragments=false --variable theme=dracula -o ";
            ssh = "kitty +kitten ssh";
            dvt = "~/.local/bin/dvt";
            weather = "curl wttr.in";
        };
    };
    programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    };
    home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;
    home.file.".local/bin/dvt".source = ./scripts/dvt;

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
}
