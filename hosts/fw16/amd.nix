{ config, lib, pkgs, ... }:
{

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        libva
        libvdpau
        libvdpau-va-gl
        vaapiVdpau
      ];
      extraPackages32 = [
        pkgs.driversi686Linux.amdvlk
      ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
