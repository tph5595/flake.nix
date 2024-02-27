{ pkgs, ... }: {
# Don't change this when you change package input. Leave it alone.
    home.stateVersion = "23.11";
# specify my home-manager configs
    home.packages = with pkgs; [
        ripgrep
        fd
        curl
        less
        neovim
        kitty
    ];
    home.sessionVariables = {
        CLICLOLOR = 1;
        VISUAL = "nvim";
        EDITOR = "$VISUAL";
        BROWSER = "firefox";
    };

    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;

    programs.git.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        #initExtraFirst = ''
            # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
            # Initialization code that may require console input (password prompts, [y/n]
            # confirmations, etc.) must go above this block; everything else may go below.
            #if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
                #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
            #fi
        #'';
        initExtra = ''
            # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            '';
        zplug = {
            enable = true;
            plugins = [
            { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
            { name = "supercrabtree/k"; tags = [depth:1]; }
            { name = "plugins/git"; tags = [from:oh-my-zsh]; }
            { name = "jeffreytse/zsh-vi-mode"; tags = [depth:1]; }
            ];
        };
        shellAliases = {
            nixswitch = "darwin-rebuild switch --flake ~/Desktop/flake.nix/.#";
            nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
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
        };
    };
    home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;
               }
