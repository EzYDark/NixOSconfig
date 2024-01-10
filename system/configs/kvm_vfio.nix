{ ... }:

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
      # "vfio_virqfd"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      # enable AMD IOMMU
      "amd_iommu=on"

      # isolate the GPU (my GTX 1070)
      "vfio-pci.ids=10de:1b81,10de:10f0"
    ];
  };

  # Enable SPICE protocol
  virtualisation.spiceUSBRedirection.enable = true;

  # System-wide apps
  programs = {
    virt-manager.enable = true;
  };
}
