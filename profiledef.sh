#!/usr/bin/env bash
# shellcheck disable=SC2034

# Mectov Linux - Arch-based distro with KDE Plasma

iso_name="mectov-linux"
iso_label="MECTOV_$(date --utc +%Y%m)"
iso_publisher="Mectov Linux <https://mectov.dev>"
iso_application="Mectov Linux Live/Installer ISO"
iso_version="$(date --utc +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=(
  'bios.syslinux'
  'uefi.grub'
)
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/usr/local/bin/mectov-install"]="0:0:755"
  ["/usr/local/bin/mectov-welcome"]="0:0:755"
  ["/root/customize_airootfs.sh"]="0:0:755"
)
