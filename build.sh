#!/usr/bin/env bash
#
# Mectov Linux ISO Build Script (Docker)
# ========================================
# Builds the Mectov Linux ISO using archiso inside a Docker container.
# Works on ANY Linux distro — no need for Arch Linux host.
#
# Requirements:
#   - Docker installed and running
#   - Root/sudo privileges
#
# Usage:
#   sudo ./build.sh
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/out"
CONTAINER_NAME="mectov-linux-builder"
DOCKER_IMAGE="archlinux:latest"

banner() {
    echo -e "${BLUE}${BOLD}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║       Mectov Linux ISO Builder       ║"
    echo "  ║     Arch-based • KDE Plasma          ║"
    echo "  ║        (Docker Build Mode)           ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${NC}"
}

log() {
    echo -e "${GREEN}[MECTOV]${NC} $1"
}

warn() {
    echo -e "${RED}[WARN]${NC} $1"
}

info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

# Check root
if [[ $EUID -ne 0 ]]; then
    warn "This script must be run as root!"
    echo "Usage: sudo ./build.sh"
    exit 1
fi

# Check Docker
if ! command -v docker &>/dev/null; then
    warn "Docker is not installed!"
    echo "Install Docker first: https://docs.docker.com/engine/install/"
    exit 1
fi

# Check Docker daemon
if ! docker info &>/dev/null; then
    warn "Docker daemon is not running!"
    echo "Start it with: sudo systemctl start docker"
    exit 1
fi

banner

# Clean previous builds
log "Cleaning previous build artifacts..."
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
rm -rf "${SCRIPT_DIR}/work"
mkdir -p "${OUT_DIR}"

# Pull latest Arch image
log "Pulling latest Arch Linux image..."
docker pull "${DOCKER_IMAGE}"

# Build ISO inside container
log "Starting ISO build inside Docker container..."
info "This may take 15-30 minutes depending on your internet speed."
echo ""

docker run --rm \
    --name "${CONTAINER_NAME}" \
    --privileged \
    -v "${SCRIPT_DIR}:/mectov-linux" \
    -v "${OUT_DIR}:/out" \
    -v "${SCRIPT_DIR}/pacman_cache:/var/cache/pacman/pkg" \
    "${DOCKER_IMAGE}" \
    /bin/bash -c '
        set -euo pipefail

        echo ">>> [Container] Applying local mirrorlist (ID/SG)..."
        cp /mectov-linux/mirrorlist /etc/pacman.d/mirrorlist

        echo ">>> [Container] Updating pacman keyring & packages..."
        pacman-key --init
        pacman-key --populate archlinux
        pacman -Sy --noconfirm archlinux-keyring
        pacman -Syu --noconfirm
        
        echo ">>> [Container] Installing archiso..."
        pacman -S --noconfirm archiso grub git

        echo ">>> [Container] Setting up EndeavourOS repository..."
        echo -e "\n[endeavouros]\nSigLevel = Never\nServer = https://mirror.alpix.eu/endeavouros/repo/endeavouros/\$arch" >> /etc/pacman.conf

        echo ">>> [Container] Setting up CachyOS repository..."
        echo -e "\n[cachyos]\nSigLevel = Never\nServer = https://mirror.cachyos.org/repo/\$arch/\$repo" >> /etc/pacman.conf

        echo ">>> [Container] Preparing build environment..."
        WORK_DIR="/tmp/archiso-work"
        PROFILE_DIR="/tmp/mectov-profile"
        
        # Copy profile to temp dir (avoid permission issues with mounted volume)
        cp -r /mectov-linux "${PROFILE_DIR}"
        rm -rf "${PROFILE_DIR}/.git"
        rm -rf "${PROFILE_DIR}/out"
        rm -rf "${PROFILE_DIR}/work"

        echo ">>> [Container] Building Mectov Linux ISO..."
        mkarchiso -v -w "${WORK_DIR}" -o /out "${PROFILE_DIR}"

        echo ""
        echo ">>> [Container] Build complete!"
        ls -lh /out/*.iso 2>/dev/null || echo "No ISO found!"
    '

echo ""
log "${BOLD}Build complete!${NC}"
info "ISO file(s) in: ${OUT_DIR}/"
ls -lh "${OUT_DIR}"/*.iso 2>/dev/null || warn "No ISO file found."

echo -e "\n${PURPLE}${BOLD}  ✨ Mectov Linux ISO is ready! ✨${NC}"
echo -e "${CYAN}  Test with: qemu-system-x86_64 -boot d -cdrom ${OUT_DIR}/mectov-linux-*.iso -m 4G -enable-kvm${NC}\n"
