# This README file contains information on the contents of the meta-efi-secure-boot-helper layer.

Please see the corresponding sections below for details.

## Dependencies

  URI: git://git.yoctoproject.org/poky
  branch: gatesgarth

  URI: git://git.openembedded.org/meta-openembedded
  branch: gatesgarth

  URI: git://github.com/jiazhang0/meta-secure-core.git
  branch: master


## Patches

Please submit any patches against the meta-efi-secure-boot-helper layer to the xxxx mailing list (xxxx@zzzz.org)
and cc: the maintainer:

Maintainer: Yusuke Mitsuki <mickey.happygolucky@gmail.com>

## Table of Contents

1. Download sources
2. Adding this layer to build
3. Edit the local.conf

###  Download sources

Run commands as follows:

```txt
$ git clone git://git.yoctoproject.org/poky -b gatesgarth
$ source poky/oe-init-build-env build
$ bitbake-layers layerindex-fetch meta-oe
$ bitbake-layers layerindex-fetch meta-efi-secure-boot -b master
```

### Adding this layer to build

Place this layer under poky. Then run commands.

```txt
$ bitbake-layers add-layer meta-efi-secure-boot-helper
```

### Edit the local.conf

Add the lines as follows to bottom of `conf/local.conf`

```bash
MACHINE = "genericx86-64"
DL_DIR = "${TOPDIR}/../downloads"

# systemd
DISTRO_FEATURES:append = " systemd pam"
VIRTUAL-RUNTIME_init_manager = "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "sysvinit"
VIRTUAL-RUNTIME_initscripts = ""

# secure boot
#SIGNING_MODEL = "user"

INITRAMFS_IMAGE = "secure-core-image-initramfs"
DISTRO_FEATURES:append = " efi-secure-boot"

IMAGE_EFI_BOOT_FILES:append = " \
        ${KERNEL_IMAGETYPE}.p7b \
        Hash2DxeCrypto.efi;EFI/BOOT/Hash2DxeCrypto.efi \
        LockDown.efi;EFI/BOOT/LockDown.efi \
        Pkcs7VerifyDxe.efi;EFI/BOOT/Pkcs7VerifyDxe.efi \
        SELoaderx64.efi;EFI/BOOT/SELoaderx64.efi \
        boot-menu.inc;EFI/BOOT/boot-menu.inc \
        boot-menu.inc.p7b;EFI/BOOT/boot-menu.inc.p7b \
        bootx64.efi;EFI/BOOT/bootx64.efi \
        efi-secure-boot.inc;EFI/BOOT/efi-secure-boot.inc \
        efi-secure-boot.inc.p7b;EFI/BOOT/efi-secure-boot.inc.p7b \
        grub.cfg;EFI/BOOT/grub.cfg \
        grub.cfg.p7b;EFI/BOOT/grub.cfg.p7b \
        grubenv;EFI/BOOT/grubenv \
        grubx64.efi;EFI/BOOT/grubx64.efi \
        mmx64.efi;EFI/BOOT/mmx64.efi \
        password.inc;EFI/BOOT/password.inc \
        password.inc.p7b;EFI/BOOT/password.inc.p7b \
"
```
