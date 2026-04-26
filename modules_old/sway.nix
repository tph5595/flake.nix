{ config, pkgs, lib, ... }:

{
    options = {
        sway.enable = 
            lib.mkEnableOption "enables sway";
    };
    config = lib.mkIf config.sway.enable {
        # https://gist.github.com/mschwaig/195fe93ed85dea7aaceaf8e1fc6c0e99
        # configuring sway itself (assmung a display manager starts it)
        systemd.user.targets.sway-session = {
            description = "Sway compositor session";
            documentation = [ "man:systemd.special(7)" ];
            bindsTo = [ "graphical-session.target" ];
            wants = [ "graphical-session-pre.target" ];
            after = [ "graphical-session-pre.target" ];
        };

        services.displayManager.defaultSession = "sway";
        #  services.xserver.displayManager.sddm.enable = true;
        services.libinput.enable = true;

        programs.sway = {
            enable = true;
            extraPackages = with pkgs; [
                swaylock
                swayidle
                xwayland
            ];
            extraSessionCommands = ''
                export SDL_VIDEODRIVER=wayland
                export QT_QPA_PLATFORM=wayland
                export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
                export _JAVA_AWT_WM_NONREPARENTING=1
                export MOZ_ENABLE_WAYLAND=1
                '';
        };
    };
}
