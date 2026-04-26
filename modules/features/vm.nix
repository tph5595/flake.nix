{ self, inputs, ... }: {

  flake.nixosModules.vm = { pkgs, lib, ... }: {
        environment.systemPackages = with pkgs; [
            virt-manager
            libguestfs
        ];

        users.users.taylor = {
            extraGroups = [ "libvirtd" ];
        };

        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    package = pkgs.qemu_kvm;
                    runAsRoot = true;
                    swtpm.enable = true;
                    # ovmf.enable = true;
                    # ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
            spiceUSBRedirection.enable = true;
        };
    };
}
