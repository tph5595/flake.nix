{ pkgs, ... }: 
{
    imports = [
        ./modules/git.nix
        ./modules/zsh.nix
        ./modules/nvim.nix
        ./modules/tmux.nix
        ./modules/direnv.nix
        ./modules/kitty.nix
    ];
    # Don't change this when you change package input. Leave it alone.
    home.stateVersion = "23.11";

    news.display = "silent";

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
            zstd
            ];

    home.sessionVariables = {
        CLICLOLOR = 1;
    };
}
