{ pkgs, config, ... }: {
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

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      # FIX for eGPU
      "pci=realloc"

      # enable AMD IOMMU
      "amd_iommu=on"

      # isolate the GPU (my GTX 1070)
      "vfio-pci.ids=10de:1b81,10de:10f0"

      # Static Hugepages (for eGPU setup)
      # "default_hugepagesz=1G"
      # "hugepagesz=1G"
      # "hugepages=12"

      # Static CPU core isolation (for eGPU setup)
      # "isolcpus=4-15"
      # "nohz_full=4-15"
      # "rcu_nocbs=4-15"
      # "irqaffinity=0,1,2,3"
      # "rcu_nocb_poll"

      # Force TSC clocks (for eGPU setup)
      "clocksource=tsc"
      "tsc=reliable"
    ];
  };

  # Enable SPICE protocol
  virtualisation.spiceUSBRedirection.enable =
    true;

  # System-wide apps
  programs = { virt-manager.enable = true; };

  environment.systemPackages = with pkgs;
    [ looking-glass-client ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ezy qemu-libvirtd -"
  ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

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
    package =
      config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
