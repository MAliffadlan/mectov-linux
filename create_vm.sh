#!/usr/bin/env bash
#
# Mectov Linux - VirtualBox VM Creator
# ======================================
# Automatically creates and launches a VirtualBox VM
# to test the Mectov Linux ISO.
#
# Usage:
#   ./create_vm.sh [path-to-iso]
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
VM_NAME="MectovLinux"
VM_DIR="${HOME}/VirtualBox VMs/${VM_NAME}"
DISK_SIZE=40960  # 40 GB
RAM_SIZE=4096    # 4 GB
VRAM_SIZE=128    # 128 MB
CPU_COUNT=4

log() { echo -e "${GREEN}[MECTOV]${NC} $1"; }
warn() { echo -e "${RED}[WARN]${NC} $1"; }
info() { echo -e "${CYAN}[INFO]${NC} $1"; }

echo -e "${BLUE}${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║    Mectov Linux VM Creator           ║"
echo "  ║    VirtualBox Test Environment       ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

# Find ISO
if [[ -n "${1:-}" ]]; then
    ISO_PATH="$1"
else
    ISO_PATH=$(find "${SCRIPT_DIR}/out" -name "mectov-linux-*.iso" -type f 2>/dev/null | sort -r | head -1)
fi

if [[ -z "${ISO_PATH}" || ! -f "${ISO_PATH}" ]]; then
    warn "No Mectov Linux ISO found!"
    echo "Build the ISO first with: sudo ./build.sh"
    echo "Or specify the path: ./create_vm.sh /path/to/iso"
    exit 1
fi

log "Found ISO: ${ISO_PATH}"
info "ISO size: $(du -h "${ISO_PATH}" | cut -f1)"

# Remove existing VM if present
if VBoxManage showvminfo "${VM_NAME}" &>/dev/null; then
    log "Removing existing VM '${VM_NAME}'..."
    VBoxManage controlvm "${VM_NAME}" poweroff 2>/dev/null || true
    sleep 2
    VBoxManage unregistervm "${VM_NAME}" --delete 2>/dev/null || true
    sleep 1
fi

# Create VM
log "Creating VM '${VM_NAME}'..."
VBoxManage createvm --name "${VM_NAME}" --ostype "ArchLinux_64" --register

# Configure VM
log "Configuring VM..."

# Basic settings
VBoxManage modifyvm "${VM_NAME}" \
    --memory "${RAM_SIZE}" \
    --vram "${VRAM_SIZE}" \
    --cpus "${CPU_COUNT}" \
    --ioapic on \
    --acpi on \
    --pae on \
    --hwvirtex on \
    --nestedpaging on \
    --largepages on \
    --graphicscontroller vmsvga \
    --accelerate3d on

# Boot order: DVD first, then disk
VBoxManage modifyvm "${VM_NAME}" \
    --boot1 dvd \
    --boot2 disk \
    --boot3 none \
    --boot4 none

# Enable EFI
VBoxManage modifyvm "${VM_NAME}" --firmware efi

# Audio (PipeWire/PulseAudio)
VBoxManage modifyvm "${VM_NAME}" \
    --audio-driver pulse \
    --audio-enabled on \
    --audio-controller hda \
    --audioout on \
    --audioin on

# Network (NAT)
VBoxManage modifyvm "${VM_NAME}" \
    --nic1 nat \
    --natpf1 "SSH,tcp,,2222,,22"

# USB 2.0
VBoxManage modifyvm "${VM_NAME}" --usbehci on 2>/dev/null || \
    VBoxManage modifyvm "${VM_NAME}" --usbohci on 2>/dev/null || true

# Clipboard & drag-and-drop
VBoxManage modifyvm "${VM_NAME}" \
    --clipboard-mode bidirectional \
    --draganddrop bidirectional

# Create storage controllers
log "Setting up storage..."

# SATA controller for HDD
VBoxManage storagectl "${VM_NAME}" \
    --name "SATA" \
    --add sata \
    --controller IntelAhci \
    --portcount 2

# Create virtual disk
DISK_PATH="${VM_DIR}/${VM_NAME}.vdi"
log "Creating ${DISK_SIZE}MB virtual disk..."
VBoxManage createmedium disk \
    --filename "${DISK_PATH}" \
    --size "${DISK_SIZE}" \
    --format VDI \
    --variant Standard

# Attach disk
VBoxManage storageattach "${VM_NAME}" \
    --storagectl "SATA" \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium "${DISK_PATH}"

# Attach ISO
VBoxManage storageattach "${VM_NAME}" \
    --storagectl "SATA" \
    --port 1 \
    --device 0 \
    --type dvddrive \
    --medium "${ISO_PATH}"

echo ""
log "${BOLD}VM '${VM_NAME}' created successfully!${NC}"
echo ""
info "VM Settings:"
echo "  • RAM:      ${RAM_SIZE} MB"
echo "  • vRAM:     ${VRAM_SIZE} MB"
echo "  • CPUs:     ${CPU_COUNT}"
echo "  • Disk:     $((DISK_SIZE / 1024)) GB"
echo "  • Firmware:  EFI"
echo "  • Graphics:  VMSVGA + 3D"
echo "  • Network:   NAT (SSH: localhost:2222)"
echo ""

# Ask to start
read -rp "$(echo -e "${PURPLE}Start the VM now? [Y/n]: ${NC}")" START_VM
START_VM="${START_VM:-Y}"

if [[ "${START_VM}" =~ ^[Yy]$ ]]; then
    log "Starting Mectov Linux VM..."
    VBoxManage startvm "${VM_NAME}" --type gui
    echo -e "\n${PURPLE}${BOLD}  🚀 Mectov Linux is booting up! ${NC}\n"
else
    info "Start manually with: VBoxManage startvm ${VM_NAME} --type gui"
fi
