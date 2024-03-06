{ pkgs, ... }: {
    home.username = "taylor";
    home.homeDirectory = "/home/taylor";

    home.packages = with pkgs; [
            kitty
            ffmpeg_5-full
            nmap
            openvpn
            subversion
            darktable
            ];
    home.sessionVariables = {
        BROWSER = "firefox";
    };
}
