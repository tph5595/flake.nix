{ pkgs, ... }: 

let 
    dvt = import ./scripts/dvt.nix { inherit pkgs; };
in 
{
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

    programs.git = {
        enable = true;
        userName  = "Taylor Henderson";
        userEmail = "tph5595@verizon.net";
        extraConfig = {
            credential.helper = "${
                pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
        };
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = false;
        syntaxHighlighting.enable = true;
        autocd = false;
        initExtraFirst = ''
            bindkey -v
            bindkey -s ^f "~/.local/bin/tmux-sessionizer\n"
            bindkey "^H" backward-delete-char
            bindkey "^?" backward-delete-char
            bindkey '^r' history-incremental-search-backward
            bindkey '^p' up-line-or-search
            bindkey '^n' down-line-or-search
            export PATH=~/.local/bin/:$PATH

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

            # Ensure agenix is running to keep secrets up to date
            # if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
                # systemctl --user start agenix.service
            # fi
            cd $HOME
            '';
        envExtra = ''
            EDITOR=nvim
        '';
        zplug = {
            enable = true;
            plugins = [
            { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
            { name = "supercrabtree/k"; tags = ["depth:1"]; }
            { name = "plugins/git"; tags = ["from:oh-my-zsh"]; }
            #{ name = "jeffreytse/zsh-vi-mode"; tags = ["depth:1"]; }
            { name ="zsh-users/zsh-syntax-highlighting"; tags = ["defer:2"]; }
            ];
        };
        shellAliases = {
            ngc = "nix-collect-garbage --delete-older-than 30d";
            # have to use impure flake because of nixGL hack with currentTime
            upug = "sudo echo ''; pushd ~/flake.nix; git pull; nix flake lock github:tph5595/flake.nix --log-format internal-json -v |& nom --json; nix flake update --log-format internal-json -v |& nom --json; nixswitch --impure |& nom;nvim --headless \"+Lazy! sync\" +qa; nvim --headless \"+MasonUpdate\" +qa;popd";
            ls = "ls --color=auto";
            whatsup = "nix flake lock github:tph5595/flake.nix";
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
            weather = "curl wttr.in";
            hush = "systemctl --user start agenix.service";
        };
    };
    programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
    };
    home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;
    # home.file.".local/bin/dvt".source = ./scripts/dvt;
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
