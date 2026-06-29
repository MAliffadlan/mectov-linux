# <img src="airootfs/root/calamares-custom/branding/mectov/mectov-logo.jpg" width="48" valign="middle" /> Mectov Linux

**An Arch-based Linux distribution with KDE Plasma and CachyOS performance kernel.**

![Arch Based](https://img.shields.io/badge/Based_on-Arch_Linux-1793D1?style=for-the-badge&logo=archlinux&logoColor=white)
![KDE Plasma](https://img.shields.io/badge/Desktop-KDE_Plasma-1D99F3?style=for-the-badge&logo=kde&logoColor=white)
![Kernel](https://img.shields.io/badge/Kernel-linux--cachyos-1dc7b5?style=for-the-badge)
![License](https://img.shields.io/badge/License-GPL_v3-blue?style=for-the-badge)

---

## Download

Latest ISO is available from our mirror:

**[Download Mectov Linux ISO](https://file.mectov.my.id/share/yGhwiFG0)**

---

## Features

- **KDE Plasma 6 Desktop** -- Modern, customizable, and feature-rich desktop environment.
- **CachyOS Kernel (BORE Scheduler)** -- Performance-optimized kernel with burst-oriented response enhancer for lower latency and smoother multitasking.
- **Fish Shell + Starship Prompt** -- Intelligent auto-completion and a fast, informative terminal prompt out of the box.
- **PipeWire Audio** -- Low-latency audio stack with full PulseAudio and JACK compatibility.
- **Full GPU Support** -- NVIDIA (proprietary), AMD, and Intel drivers included.
- **Calamares Graphical Installer** -- Guided installation with disk partitioning, user setup, and bootloader configuration.
- **Flatpak Ready** -- Access to thousands of sandboxed applications via Flathub.
- **Arch Rolling Release** -- Always running the latest stable software.

---

## Pre-installed Software

| Category | Software |
|----------|----------|
| Browser | Firefox |
| File Manager | Dolphin |
| Terminal | Konsole (Fish + Starship) |
| Text Editor | Kate |
| Media Player | VLC |
| System Monitor | Plasma System Monitor, btop |
| Screenshot | Spectacle |
| Archive Manager | Ark |

---

## Building the ISO

### Requirements

- Docker (recommended) or an Arch Linux host system
- Git

### Build

```bash
git clone https://github.com/MAliffadlan/mectov-linux.git
cd mectov-linux
sudo ./build.sh
```

The build script uses Docker to pull the latest Arch Linux image and run `mkarchiso` inside a privileged container. Downloaded packages are cached locally in `pacman_cache/` to speed up subsequent builds.

The resulting ISO will be placed in the `out/` directory.

### Testing with QEMU

```bash
qemu-system-x86_64 \
  -boot d \
  -cdrom out/mectov-linux-*.iso \
  -m 4G \
  -enable-kvm \
  -cpu host \
  -smp 4
```

### Testing with VirtualBox

Create a VM with the following recommended settings:

- **Firmware**: EFI
- **RAM**: 4 GB
- **CPU**: 4 cores
- **Disk**: 40 GB
- **Graphics**: VMSVGA with 3D Acceleration enabled

---

## Live Environment Credentials

| Field | Value |
|-------|-------|
| Username | `mectov` |
| Password | `mectov` |
| Root password | `mectov` |

---

## Project Structure

```
MectovLinux/
├── profiledef.sh              # Archiso profile definition
├── packages.x86_64            # Package list
├── pacman.conf                 # Pacman configuration (Arch + CachyOS repos)
├── build.sh                   # Docker-based build script
├── airootfs/                  # Root filesystem overlay
│   ├── etc/
│   │   ├── hostname
│   │   ├── locale.conf
│   │   ├── os-release
│   │   ├── skel/              # Default user configuration
│   │   ├── sddm.conf.d/      # Display manager configuration
│   │   └── xdg/
│   ├── root/
│   │   ├── customize_airootfs.sh
│   │   └── calamares-custom/  # Calamares installer configuration and branding
│   └── usr/
│       └── local/bin/         # mectov-welcome, mectov-install
├── efiboot/                   # EFI bootloader entries
├── grub/                      # GRUB bootloader configuration
└── syslinux/                  # BIOS bootloader configuration
```

---

## Credits

- [Arch Linux](https://archlinux.org) -- Base system
- [KDE Plasma](https://kde.org/plasma-desktop/) -- Desktop environment
- [CachyOS](https://cachyos.org) -- Performance kernel and optimized repositories
- [Calamares](https://calamares.io) -- Graphical system installer
- [archiso](https://gitlab.archlinux.org/archlinux/archiso) -- ISO build tool

---

## License

This project is licensed under the GPL-3.0 License.
