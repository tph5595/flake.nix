{ config, pkgs, lib, ... }: {
    options = {
        darwin.enable = 
            lib.mkEnableOption "enables darwin";
        darwin.user = 
            lib.mkOption {
                type = with lib.types; str;
                default = "taylor";
                description = "Set username";
            };
        darwin.touch-id = 
            lib.mkEnableOption "enables mac TouchID";
    };
    config = lib.mkIf config.darwin.enable {
        # here go the darwin preferences and config items
        programs.zsh.enable = true;
        environment = {
            shells = with pkgs; [ bash zsh ];
            loginShell = pkgs.zsh;
            systemPackages = [ pkgs.coreutils-full ];
            pathsToLink = [ "/Applications" ];
        };
        nix.extraOptions = ''
            experimental-features = nix-command flakes
            '';
        system.keyboard.enableKeyMapping = true;
        # system.keyboard.remapCapsLockToEscape = true;
        fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "Hack" ]; }) ];
        services.nix-daemon.enable = true;
        system.defaults = {
            dock.autohide = true;
            finder.AppleShowAllExtensions = true;
            NSGlobalDomain.AppleShowAllExtensions = true;
        };
        # backwards compat; don't change
        system.stateVersion = 4;
        users.users.taylor = {
            name = config.darwin.user;
            home = "/Users/${config.darwin.user}";
        };
        # Enable TouchID as valid password source
        security.pam.enableSudoTouchIdAuth = config.darwin.touch-id;
    };
}
