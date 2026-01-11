# Libvirt + QEMU + virt-manager Distrobox

[![Build arch-libvirt image](https://github.com/hecknt/toolboxes/actions/workflows/build-libvirt-toolbox.yml/badge.svg)](https://github.com/hecknt/toolboxes/actions/workflows/build-libvirt-toolbox.yml)

arch-libvirt is an [Arch Linux](https://archlinux.org) based OCI image designed for use in [distrobox](https://distrobox.it). It can be used on any linux distribution with [distrobox](https://distrobox.it) installed.

## Usage

> [!IMPORTANT]
>
> This image has to be created as a rootful distrobox. Libvirt uses KVM, which requires root access.
>
> If you do not have sudo access on your user, you will not be able to use this toolbox as intended.

To create the distrobox, run the following commands:

```bash
distrobox create --root --init \
    --init-hooks "usermod -aG libvirt ${USER}" \
    --image ghcr.io/hecknt/arch-libvirt:latest \
    --name libvirt
```

This will create the distrobox with an init hook to add your user to the libvirt group inside of the container. 

Once the image has been created, you can optionally export the pre-installed [Virtual Machine Manager](https://virt-manager.org/) with the following command:

```bash
distrobox enter --root --name libvirt -- distrobox-export --app virt-manager
```

After this, you will have `Virtual Machine Manager (on libvirt)` as an application entry in your application launcher. Launch it, create a virtual machine, and it will run right out of the box! <sub>(provided you have virtualization enabled in your motherboard's bios)</sub>

<img width="571" height="177" alt="image" src="https://github.com/user-attachments/assets/f1f65d9c-caf5-49ee-842a-a02d8f48bf04" />


## Bypass the password prompt

> [!WARNING]
>
> The following instructions will degrade the security of your system, as it will allow for your user to run a specific command with `sudo` without entering a password.
>
> If you do not want to degrade the security of your system in this way, do **NOT** follow the upcoming instructions. If you do not care, then you may follow these instructions.

By default, since you have installed this image as a rootful distrobox, you will receive a pop-up to enter your password every time you use the application entry to launch [Virtual Machine Manager](https://virt-manager.org/).

<img width="369" height="263" alt="image" src="https://github.com/user-attachments/assets/ba7a22c3-3bc4-4483-917d-60abf02585d2" />

In order to bypass the prompt, you may add the following line of text to the bottom of your sudoers file by running `sudo visudo`:

```
%wheel      ALL=(ALL:ALL) NOPASSWD: /usr/bin/podman
```

This will allow any user in the `wheel` group to run `podman` with `sudo` without typing a password, and will therefore remove the password prompt.

## Verification

This image, like all the other images in this repository, is signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/hecknt/arch-libvirt:latest
```
