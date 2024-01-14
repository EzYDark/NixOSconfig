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
    ./configs/openssh.nix
    ./configs/garbage_collection.nix
    ./configs/networking.nix
    ./configs/xserver_gnome.nix
    ./configs/kvm_vfio.nix         ### 1) Select this or
    # ./configs/gpu_nvidia.nix     ### 2) This one only!
    ./configs/droidcam.nix
    # ./configs/opengl.nix
    # ./configs/containers.nix
    ./configs/xone.nix
    ./configs/huawei-wmi.nix
    ./configs/parsec.nix
    ./configs/telegram.nix
    ./configs/figma.nix
    ./configs/keyd.nix
  ];
}