# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /etc/nixos/system/configs/disk_partitions.nix

# btrfs subvolume snapshot -r /mnt /mnt/persist/_snapshots/.root-blank

# nixos-generate-config --no-filesystems --root /mnt
# nixos-install --no-root-password
# reboot




{ pkgs, ... }:
{
  # Note `lib.mkBefore` is used instead of `lib.mkAfter` here.
  boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
    root_subvolume="@root"
    disk_device="/dev/disk/by-id/ata-WDC_PC_SN530_SDBPNPZ-512G-1027_20245T494806-part2"

    mkdir -p /mnt

    # Mount the btrfs subvolume @root to /mnt
    sudo mount -t btrfs -o subvol=$root_subvolume,defaults,compress=zstd $disk_device /mnt

    # While we're tempted to just delete @root and create
    # a new snapshot from @persist_snapshots/.root_blank, @root is already
    # populated at this point with a number of subvolumes,
    # which makes `btrfs subvolume delete` fail.
    # So, we remove them first.
    #
    # @root contains subvolumes:
    # - @root/var/lib/portables
    # - @root/var/lib/machines
    #
    # I suspect these are related to systemd-nspawn, but
    # since I don't use it I'm not 100% sure.
    # Anyhow, deleting these subvolumes hasn't resulted
    # in any issues so far, except for fairly
    # benign-looking errors from systemd-tmpfiles.
    btrfs subvolume list -o /mnt |
    awk '{print $9}' |
    while read subvolume; do
      echo " - Deleting /$subvolume subvolume..."
      subvolume=$(echo $subvolume | sed "s/$root_subvolume\///")
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    echo " - Deleting $root_subvolume subvolume..." &&
    btrfs subvolume delete /mnt

    echo " - Restoring blank $root_subvolume subvolume..."
    btrfs subvolume snapshot /mnt/persist/_snapshots/.root-blank /mnt/root

    # Once we're done rolling back to a blank snapshot,
    # we can unmount /mnt and continue on the boot process.
    umount /mnt
  '';
}