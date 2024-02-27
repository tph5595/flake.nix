{ pkgs, ... }: {
# here go the darwin preferences and config items
    programs.zsh.enable = true;
    environment = {
        shells = with pkgs; [ bash zsh ];
        loginShell = pkgs.zsh;
        systemPackages = [ pkgs.coreutils ];
        pathsToLink = [ "/Applications" ];
    };
    nix.extraOptions = ''
        experimental-features = nix-command flakes
        '';
    system.keyboard.enableKeyMapping = true;
# system.keyboard.remapCapsLockToEscape = true;
    fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Hack" ]; }) ];
    services.nix-daemon.enable = true;
    system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
        NSGlobalDomain.AppleShowAllExtensions = true;
    };
# backwards compat; don't change
    system.stateVersion = 4;
    users.users.taylor = {
        name = "taylor";
        home = "/Users/taylor";
    };
               }
