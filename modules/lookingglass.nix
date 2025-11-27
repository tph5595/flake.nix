{ config, pkgs, lib, ... }:
{
    options = {
        looking-glass.enable = 
            lib.mkEnableOption "enables looking-glass";
    };
    config = lib.mkIf config.looking-glass.enable {
        environment.systemPackages = with pkgs; [
            virt-manager
        ];
        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    swtpm.enable = true;
                    # ovmf.enable = true;
                    # ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
            spiceUSBRedirection.enable = true;
        };
    };
}
