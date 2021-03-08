SRC_URI += "file://resolve_efi_dir.patch;subdir=git"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
DEPENDS += "binutils-native"
