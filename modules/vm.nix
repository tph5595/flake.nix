{ config, pkgs, lib, ... }:
{

    options = {
        vm.enable = 
            lib.mkEnableOption "enables vms";
    };
    config = lib.mkIf config.vm.enable {
        environment.systemPackages = with pkgs; [
            virt-manager
        ];
        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    swtpm.enable = true;
                    ovmf.enable = true;
                    ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
            spiceUSBRedirection.enable = true;
        };
    };
}
