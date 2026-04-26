{ self, inputs, ... }: {

    flake.nixosModules.docker = { pkgs, lib, ... }: {

        virtualisation.docker.enable = true;

        users.groups.docker.members = ["taylor"];
    };
}
