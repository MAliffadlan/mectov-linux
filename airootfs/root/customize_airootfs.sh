#!/usr/bin/env bash
# ============================================
# Mectov Linux - Airootfs Customization Script
# Runs during ISO build to configure the live env
# ============================================
set -e -u

echo ">>> Mectov Linux: Customizing airootfs..."

# Set locale
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Enable services
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable sddm.service
systemctl enable reflector.timer
systemctl enable fstrim.timer

# Create live user
useradd -m -G wheel,video,audio,storage,optical,network,power -s /usr/bin/fish mectov
echo "mectov:mectov" | chpasswd
echo "root:mectov" | chpasswd

# Allow wheel group to use sudo
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Set timezone
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Configure SDDM autologin for live session
mkdir -p /etc/sddm.conf.d
cat > /etc/sddm.conf.d/autologin.conf << 'SDDM'
[Autologin]
User=mectov
Session=plasma
SDDM

# Create user dirs
su - mectov -c "xdg-user-dirs-update" 2>/dev/null || true

# Enable Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true

# Copy custom Calamares configuration (overwriting default package config)
if [ -d "/root/calamares-custom" ]; then
    echo ">>> Mectov Linux: Applying custom Calamares configurations..."
    mkdir -p /etc/calamares
    cp -rf /root/calamares-custom/* /etc/calamares/
    rm -rf /root/calamares-custom
fi

echo ">>> Mectov Linux: Customization complete!"
