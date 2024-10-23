{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.nvidia-gpu;
in {
  options.${namespace}.hardware.nvidia-gpu = with types; {
    enable = mkBoolOpt false "Whether or not to enable NVIDIA GPU support.";
  };

  config = mkIf cfg.enable {

    boot = {
      initrd.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        # FIX for eGPU
        "pci=realloc"
      ];
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      package =
        # config.boot.kernelPackages.nvidiaPackages.stable;
        # config.boot.kernelPackages.nvidiaPackages.production;
        config.boot.kernelPackages.nvidiaPackages.beta;
    };

  };
}