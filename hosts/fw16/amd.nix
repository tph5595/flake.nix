{ config, lib, pkgs, ... }:
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
            # amdvlk
            libva
            libvdpau
            libvdpau-va-gl
            libva-vdpau-driver
            rocmPackages.clr.icd
    ];
    # extraPackages32 = [
    #     pkgs.driversi686Linux.amdvlk
    # ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
