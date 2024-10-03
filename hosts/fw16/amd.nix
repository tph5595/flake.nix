{ config, lib, pkgs, ... }:
{

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
#    extraPackages = with pkgs; [
#      # trying to fix `WLR_RENDERER=vulkan sway`
#      vulkan-validation-layers
#      # https://nixos.wiki/wiki/Accelerated_Video_Playback
#      intel-media-driver # LIBVA_DRIVER_NAME=iHD
#      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
#      vaapiVdpau
#      libvdpau-va-gl
#    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
