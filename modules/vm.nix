{ config, pkgs, lib, ... }:
{

    options = {
        vm.enable = 
            lib.mkEnableOption "enables vms";
        vm.libvirtd_user = 
            lib.mkOption {
                type = with lib.types; str;
                default = "taylor";
                description = "Set libvirtd user";
            };
    };
    config = lib.mkIf config.vm.enable {
        environment.systemPackages = with pkgs; [
            virt-manager
            libguestfs
        ];

        users.users.${config.vm.libvirtd_user}= {
            extraGroups = [ "libvirtd" ];
        };

        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    package = pkgs.qemu_kvm;
                    runAsRoot = true;
                    swtpm.enable = true;
                    ovmf.enable = true;
                    ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
            spiceUSBRedirection.enable = true;
        };
    };
}
