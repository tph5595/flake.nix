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
	system.primaryUser = "hendetp1";
        programs.zsh.enable = true;
        environment = {
            shells = with pkgs; [ bash zsh ];
            systemPackages = [ pkgs.coreutils-full ];
            pathsToLink = [ "/Applications" ];
        };
        nix.extraOptions = ''
            experimental-features = nix-command flakes
            '';
        system.keyboard.enableKeyMapping = true;
        # system.keyboard.remapCapsLockToEscape = true;
        #fonts.packages = [pkgs.nerd-fonts.hack];
        system.defaults = {
            dock.autohide = true;
            finder.AppleShowAllExtensions = true;
            NSGlobalDomain.AppleShowAllExtensions = true;
        };
        # backwards compat; don't change
        system.stateVersion = 6;
        users.users.hendetp1 = {
            name = config.darwin.user;
            home = "/Users/hendetp1";
        };
        # Enable TouchID as valid password source
	security.pam.services.sudo_local.touchIdAuth = config.darwin.touch-id;
    };
}












