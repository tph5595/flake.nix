{ config, lib, pkgs, ... }: 
{
    systemd.user.services.dropbox = {
        Unit = {
            Description = "My dropbox service";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
        Service = {
            # Type = "exec";
            ExecStart = "${pkgs.dropbox}/bin/dropbox";
            # Restart = "on-failure";
            # RestartSec = 2;
        };
    };
}
