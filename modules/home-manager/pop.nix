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
            # General
            ffmpeg_5-full
            glibc
            # GUI Apps
            kitty
            openvpn
            darktable
            bitwig-studio
            discord
            librewolf
            steam
            zoom-us
            davinci-resolve
            anki
            vlc
            tidal-hifi
            obsidian
            # https://github.com/nix-community/nixGL/issues/114
            # https://discourse.nixos.org/t/fixing-error-attribute-currentsystem-missing-in-flake/22386/6
            # nixgl.auto.nixGLNvidia
            golden-cheetah
            R
            ];
    home.sessionVariables = {
        BROWSER = "librewolf";
    };

    programs.zsh.shellAliases.nixswitch = "home-manager switch --flake ~/flake.nix/.#$HOST";

    home.sessionVariables = {
        # QT_XCB_GL_INTEGRATION="none";
    };
}
