{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

    systemd.user.startServices = "sd-switch";

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
            # https://github.com/nix-community/nixGL/issues/114
            # https://discourse.nixos.org/t/fixing-error-attribute-currentsystem-missing-in-flake/22386/6
            # nixgl.auto.nixGLNvidia
            golden-cheetah
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
