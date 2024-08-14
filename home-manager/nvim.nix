{ pkgs, lib, config, ... }: 
{
    home.sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
    };
    
    home.packages = with pkgs; [
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
        python310Packages.virtualenv
    ];

    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;

    home.file."./.config/nvim/" = {
        source = ../config/nvim;
        recursive = true;
    };
}
