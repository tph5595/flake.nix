# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules
      ./amd.nix
    ];

  docker.enable = true;
  vm.enable = true;
  k3s.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Saftey boot to root shell
  # DO NOT ENABLE PERMENENTLY!!! ONLY FOR IMMEDIATE REPAIRS 
  # Gives root shell without password
  # boot.kernelParams = ["boot.shell_on_fail"];
  # boot.loader.systemd-boot.consoleMode = "auto";

  looking-glass.enable = true;
  systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 codemichael qemu-libvirtd -"
  ];
  environment.systemPackages = with pkgs; [
      linuxPackages.kvmfr
      looking-glass-client
      qmk
      qmk-udev-rules
      pamixer
      networkmanager-vpnc
  ];

  # Increase ulimit
  security.pam.loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
  }];

  hardware.keyboard.qmk.enable = true;

  networking.hostName = "fw16"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio = {
      enable = false;
      # package = pkgs.pulseaudioFull;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.taylor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Taylor";
    extraGroups = [ 
    "networkmanager" 
    "wheel" 
    "libvirtd"
    "qemu-libvirtd"
    "plugdev"
    "bluetooth"
    # These two are needed for gns3
    "ubridge" 
    "libvirt"
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
      R
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.askPassword = "";
  services.tailscale.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      # Screen Brightness
      # F7
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      # F8
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }

      # Audio
      # # F1
      # { keys = [ 113 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pamixer -t &> /home/logit_me"; }
      # # F2
      # { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pamixer -i 10"; }
      # # F3
      # { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pamixer -d 10"; }
    ];
  };

  programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  fonts.packages = with pkgs; [
      nerd-fonts.hack
  ];
}
