# 🐧 Mectov Linux

**An Arch-based Linux distribution with KDE Plasma**

![Arch Based](https://img.shields.io/badge/Based_on-Arch_Linux-1793D1?style=for-the-badge&logo=archlinux&logoColor=white)
![KDE Plasma](https://img.shields.io/badge/Desktop-KDE_Plasma-1D99F3?style=for-the-badge&logo=kde&logoColor=white)
![License](https://img.shields.io/badge/License-GPL_v3-blue?style=for-the-badge)

## ✨ Features

- 🖥️ **KDE Plasma Desktop** — Beautiful, customizable, and powerful
- 🐟 **Fish Shell + Starship** — Modern shell with a stunning prompt
- 🔊 **PipeWire Audio** — Low-latency audio that just works
- 🎮 **GPU Drivers** — NVIDIA, AMD, and Intel out of the box
- 📦 **Flatpak Ready** — Access thousands of apps
- 🛡️ **Calamares Installer** — Easy graphical installation
- 🎨 **Emerald Teal Theme** — Clean, dark-slate visual theme (CachyOS style)
- ⚡ **Arch Rolling Release** — Always up to date

## 📥 Download

You can download the latest built ISO of Mectov Linux from our private home server:

* **[Download Mectov Linux ISO (Mirror 1)](PASTE_YOUR_FILEBROWSER_SHARE_LINK_HERE)**


## 📦 Pre-installed Software

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

## 🔧 Building the ISO

### Prerequisites

- An **Arch Linux** host system (or Arch-based distro)
- `archiso` package installed

```bash
sudo pacman -S archiso
```

### Build

```bash
git clone https://github.com/mectov/mectov-linux.git
cd mectov-linux
sudo ./build.sh
```

The ISO will be generated in the `out/` directory.

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

## 🎨 Customization

### Color Palette (Tokyo Night)

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#1a1b26` | Main background |
| Foreground | `#c0caf5` | Main text |
| Blue | `#7aa2f7` | Accents, prompts |
| Purple | `#bb9af7` | Highlights |
| Cyan | `#7dcfff` | Info, paths |
| Green | `#9ece6a` | Success |
| Red | `#f7768e` | Errors |
| Yellow | `#e0af68` | Warnings |

### Modifying Packages

Edit `packages.x86_64` to add or remove packages from the ISO.

### Live Environment

- **Username:** `mectov`
- **Password:** `mectov`
- **Root password:** `mectov`

## 📁 Project Structure

```
MectovLinux/
├── profiledef.sh              # Archiso profile definition
├── packages.x86_64            # Package list
├── pacman.conf                # Pacman configuration
├── build.sh                   # Build script
├── airootfs/                  # Root filesystem overlay
│   ├── etc/
│   │   ├── hostname           # System hostname
│   │   ├── locale.conf        # Locale settings
│   │   ├── os-release         # OS branding
│   │   ├── skel/              # User skeleton (default configs)
│   │   │   └── .config/       # Default user config
│   │   ├── calamares/         # Calamares installer config
│   │   ├── sddm.conf.d/      # SDDM display manager config
│   │   └── xdg/               # XDG desktop config
│   └── usr/
│       ├── local/bin/         # Custom scripts
│       └── share/applications/ # Desktop entries
├── efiboot/                   # EFI bootloader config
├── grub/                      # GRUB bootloader config
└── syslinux/                  # BIOS bootloader config
```

## 📄 License

GPL-3.0 License

## 💜 Credits

- [Arch Linux](https://archlinux.org) — Base system
- [KDE Plasma](https://kde.org/plasma-desktop/) — Desktop environment
- [Calamares](https://calamares.io) — System installer
- [archiso](https://gitlab.archlinux.org/archlinux/archiso) — ISO build tool
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) — Color theme inspiration

---

**Made with ❤️ by Mectov**
