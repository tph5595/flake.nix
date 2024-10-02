{ config, lib, pkgs, ... }: 
{
    home.packages = with pkgs; [
        # Terminal emulator
        foot
        # dmenu style bar
        fuzzel
        # copying around
        wl-clipboard
        # Screenshot
        grim 
        slurp
        # Idle and lock
    ];

    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
                before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
                after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
            };

            listener = [
                {
                    timeout = 150;                                # 2.5min.
                    on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
                    on-resume = "brightnessctl -r";                 # monitor backlight restore.
                }

                # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
                { 
                    timeout = 150;                                          # 2.5min.
                    on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
                    on-resume = "brightnessctl -rd rgb:kbd_backlight";        # turn on keyboard backlight.
                }

                {
                    timeout = 300;                                 # 5min
                    on-timeout = "loginctl lock-session";            # lock screen when timeout has passed
                }

                {
                    timeout = 330;                                 # 5.5min
                    on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
                    on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
                }

                {
                    timeout = 1800;                                # 30min
                    on-timeout = "systemctl suspend";                # suspend pc
                }
            ];
        };
    };
    programs.hyprlock.enable = true;


    home.file."./.config/foot" = {
        source = ../../config/foot;
        recursive = true;
    };
    home.file."./.config/sway" = {
        source = ../../config/sway;
        recursive = true;
    };
    home.file."./.config/hypr/" = {
        source = ../../config/hypr;
        recursive = true;
    };
    home.file."./.config/waybar/" = {
        source = ../../config/waybar;
        recursive = true;
    };
    home.file."./.config/fuzzel" = {
        source = ../../config/fuzzel;
        recursive = true;
    };

    home.file.".local/bin/status_bar.sh".source = ../../bin/status_bar.sh;
    home.file.".local/bin/cmus_song".source = ../../bin/cmus_song;
    home.file.".local/bin/createTask".source = ../../bin/createTask;
}
