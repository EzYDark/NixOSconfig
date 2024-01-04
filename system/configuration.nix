# IOMMU Group 9:
#         03:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP104 [GeForce GTX 1070] [10de:1b81] (rev a1)
#         03:00.1 Audio device [0403]: NVIDIA Corporation GP104 High Definition Audio Controller [10de:10f0] (rev a1)

{ lib, pkgs, config, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
    };
  };

  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      # enable IOMMU
      "amd_iommu=on"
      # FIX for eGPU
      "pci=realloc"
      # isolate the GPU
      "vfio-pci.ids=10de:1b81,10de:10f0"
    ];
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable SPICE protocol
  virtualisation.spiceUSBRedirection.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Set the system's timezone to Prague.
  time.timeZone = "Europe/Prague";

  # Set the system's locale to English.
  i18n.defaultLocale = "en_US.UTF-8";

  # Disable the SSH server.
  services.openssh.enable = false;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System-wide apps
  programs = {
    # Flakes use Git to pull dependencies from data sources 
    git.enable = true;
    virt-manager.enable = true;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    
  ];

  users.mutableUsers = false;
  
  networking.firewall.enable = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.tmp.cleanOnBoot = true;
  
  # boot.kernelParams = [ "pci=realloc" ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ezy = {
    isNormalUser = true;
    password = "1234";
    extraGroups = ["networkmanager" "wheel"];
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.power-profiles-daemon = {
    enable = true;
  };
  
  system.stateVersion = "23.11";
}
