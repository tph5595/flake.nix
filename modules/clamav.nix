{ config, pkgs, lib, ... }:

{
    options = {
        clamav.enable = 
            lib.mkEnableOption "enables clamav";
    };
    config = lib.mkIf config.clamav.enable {
        services.clamav = {
            daemon.enable = true;
            updater.enable = true;
            scanner.enable = true;
        };
    };
}
