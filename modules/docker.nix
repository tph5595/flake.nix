{ config, pkgs, lib, ... }:
{

    options = {
        docker.enable = 
            lib.mkEnableOption "enables docker";
        docker.docker_users = 
            lib.mkOption {
                type = with lib.types; listOf str;
                default = ["taylor"];
                description = "Set docker users group";
            };
    };
    config = lib.mkIf config.docker.enable {
        virtualisation.docker.enable = true;

        users.groups.docker.members = config.docker.docker_users;
    };
}
