FROM ghcr.io/hecknt/arch-toolbox:latest
 
LABEL com.github.containers.toolbox="true" \
  usage="This image is meant to be used with the toolbox or distrobox command" \
  summary="A cloud-native terminal experience powered by Arch Linux"

# Add Chaotic AUR Repo
RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
RUN pacman-key --init && pacman-key --lsign-key 3056513887B78AEB
RUN pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
RUN pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
RUN echo -e '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

RUN pacman -Syu --noconfirm

# Install the juice
RUN pacman -Syu --noconfirm --needed \
  mesa \
  libva-intel-driver \
  libva-mesa-driver \
  vpl-gpu-rt \
  vulkan-icd-loader \
  vulkan-intel \
  vulkan-radeon \
  lib32-vulkan-icd-loader \
  lib32-vulkan-intel \
  lib32-vulkan-radeon \
  lib32-mesa \
  lib32-pipewire \
  lib32-pipewire-jack \
  lib32-libpulse \
  lib32-mangohud \
  xdg-user-dirs \
  steam \
  gamescope \
  umu-launcher \
  wine \
  winetricks \
  mangohud \
  lutris \
  clinfo \
  chaotic-aur/obs-vkcapture-git \
  chaotic-aur/lib32-obs-vkcapture-git \
  chaotic-aur/steamcmd \
  chaotic-aur/protontricks-git

# Cleanup
RUN rm -rf /var/cache/pacman/pkg/*
