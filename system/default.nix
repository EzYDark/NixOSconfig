{ ... }:

{
  imports = [
    ./configs/boot.nix
    ./configs/experimental_flake.nix
    ./hardware-configuration.nix
    ./configs/disk_partitions.nix
    ./configuration.nix
    ./configs/system_config.nix

    ./configs/users_groups.nix

    ./configs/sound_pipewire.nix
    ./configs/zram.nix
    ./configs/power_management.nix
    ./configs/kvm_vfio.nix
    ./configs/openssh.nix
    ./configs/garbage_collection.nix
    ./configs/networking.nix
    ./configs/xserver_gnome.nix
    ./configs/gpu_nvidia.nix
  ];
}