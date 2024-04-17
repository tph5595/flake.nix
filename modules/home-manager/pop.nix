{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

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
            # steam
            zoom-us
            # davinci-resolve
            # anki
            vlc
            tidal-hifi
            # nixgl.auto.nixGLNvidia
            # golden-cheetah
            R
            glibc
            obsidian
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };

    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";

    home.sessionVariables = {
        # QT_XCB_GL_INTEGRATION="none";
    };
}
