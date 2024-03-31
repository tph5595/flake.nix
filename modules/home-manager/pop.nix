{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
            kitty
            ffmpeg_5-full
            nmap
            openvpn
            subversion
            darktable
            bitwig-studio
            discord
            htop
            librewolf
            steam
            zoom-us
            davinci-resolve
            anki
            vlc
            tidal-hifi
            golden-cheetah
            # nixgl.auto.nixGLNvidia
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";

    home.sessionVariables = {
        QT_XCB_GL_INTEGRATION="none";
    };
}
