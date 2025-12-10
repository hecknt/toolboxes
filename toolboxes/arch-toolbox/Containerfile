FROM docker.io/archlinux/archlinux:latest
 
LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience powered by Arch Linux"

COPY system_files /
RUN sed -i -e 's/NoProgressBar/#NoProgressBar/' -e 's/NoExtract/#NoExtract/' /etc/pacman.conf

# Install packages that distrobox installs to speed up first boot
RUN pacman -Syu --needed --noconfirm \
		bash-completion \
		bc \
		curl \
		diffutils \
		findutils \
		glibc \
    glibc-locales \
    git \
		gnupg \
		iputils \
		inetutils \
		keyutils \
		less \
		lsof \
		man-db \
		man-pages \
		mlocate \
		mtr \
		ncurses \
		nss-mdns \
		openssh \
		pigz \
		pinentry \
		procps-ng \
		rsync \
		shadow \
		sudo \
		tcpdump \
		time \
		traceroute \
		tree \
		tzdata \
		unzip \
		util-linux \
		util-linux-libs \
		vte-common \
		wget \
		words \
		xorg-xauth \
		zip \
		mesa \
		vulkan-intel \
		vulkan-radeon

# Distrobox Integration
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/flatpak && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox

# Helpful packages
RUN pacman -Syu --needed --noconfirm \
  nano \
  micro \
  neovim \
  pipewire \
  pipewire-pulse \
  pipewire-jack \
  pipewire-alsa \
  wireplumber \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra

# Cleanup
RUN rm -rf /var/cache/pacman/pkg/*
