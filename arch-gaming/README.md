# Gaming Toolbox with Steam and Gamescope

[![Build arch-gaming image](https://github.com/hecknt/toolboxes/actions/workflows/build-arch-gaming.yml/badge.svg)](https://github.com/hecknt/toolboxes/actions/workflows/build-arch-gaming.yml)

arch-gaming is an [Arch Linux](https://archlinux.org) based OCI image designed for use in [distrobox](https://distrobox.it). It can be used on any linux distribution with [distrobox](https://distrobox.it) installed.

It includes Steam, Gamescope, Lutris, Mangohud, Protontricks, and every single driver and 32-bit library needed to run video games.

## Usage

To create the distrobox, run the following commands:

```bash
  distrobox create \
    --init-hooks "install -o "$(id -u)" -g "$(id -g)" -d /tmp/.X11-unix-upper-"$(id -u)"; \
    install -o "$(id -u)" -g "$(id -g)" -d /tmp/.X11-unix-work-"$(id -u)"; \
    mount -t overlay -o lowerdir=/tmp/.X11-unix,upperdir=/tmp/.X11-unix-upper-"$(id -u)",workdir=/tmp/.X11-unix-work-"$(id -u)" overlay /tmp/.X11-unix" \
    --image ghcr.io/hecknt/arch-gaming:latest \
    --name gaming-toolbox
```

This will create the distrobox with an init hook that allows for gamescope to function.

Once the image has been created, you can optionally export the pre-installed applications with the following commands:

```bash
distrobox enter --name gaming-toolbox -- distrobox-export --app steam
distrobox enter --name gaming-toolbox -- distrobox-export --app lutris
distrobox enter --name gaming-toolbox -- distrobox-export --app protontricks
```

After this, you will have several `(on gaming-toolbox)` application entries in your application launcher, and Steam should work right out of the box!

<img width="535" height="314" alt="image" src="https://github.com/user-attachments/assets/478f852d-97aa-4f0b-939c-f54df152ba3d" />

## Verification

This image, like all the other images in this repository, is signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/hecknt/arch-gaming:latest
```
