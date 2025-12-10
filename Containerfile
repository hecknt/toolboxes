FROM ghcr.io/hecknt/arch-toolbox:latest
 
LABEL com.github.containers.toolbox="true" \
  usage="This image is meant to be used with the toolbox or distrobox command" \
  summary="A cloud-native terminal experience powered by Arch Linux"

# Libvirt
RUN pacman -Syu --needed --noconfirm \ 
  libvirt \
  virt-manager \
  guestfs-tools \
  swtpm \
  qemu-desktop \
  dnsmasq \
  dmidecode

RUN systemctl enable libvirtd

# Enable default network to autostart, otherwise things break
RUN ln -sv /etc/libvirt/qemu/networks/default.xml /etc/libvirt/qemu/networks/autostart/default.xml

# Cleanup
RUN rm -rf /var/cache/pacman/pkg/*
