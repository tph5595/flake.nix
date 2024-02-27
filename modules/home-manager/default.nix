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
        zsh-vi-mode
        zsh-powerlevel10k
        kitty
    ];
    home.sessionVariables = {
        CLICLOLOR = 1;
        VISUAL="nvim";
        EDITOR="$VISUAL";
        BROWSER="firefox";
    };

    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;

    programs.git.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
#        oh-my-zsh = {
#            enable = true;
#            plugins = [ "git" "k" "zsh-vi-mode" ];
#            theme = "robbyrussel";
#        };
        zplug = {
            enable = true;
            plugins = [
            { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
            { name = "plugins/git"; tags = [from:oh-my-zsh]; }
            { name = "plugins/zsh-vi-mode"; tags = [from:oh-my-zsh]; }
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
