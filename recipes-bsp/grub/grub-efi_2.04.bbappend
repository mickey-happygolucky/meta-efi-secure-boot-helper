FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

#SRC_URI_remove_class-target = "file://0004-efi-chainloader-port-shim-to-grub.patch"

# avoid the installing grubx64.efi which does not certified.
do_deploy() {
}

# override the do_deploy
do_deploy_append_class-target() {
    install -m 0644 "${D}${EFI_BOOT_PATH}/${GRUB_IMAGE}" "${DEPLOYDIR}"

    # Deploy the stacked grub configs.
    install -m 0600 "${D}${EFI_BOOT_PATH}/grubenv" "${DEPLOYDIR}"
    install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg" "${DEPLOYDIR}"
    install -m 0600 "${D}${EFI_BOOT_PATH}/boot-menu.inc" "${DEPLOYDIR}"
    install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg${SB_FILE_EXT}" "${DEPLOYDIR}"
    install -m 0600 "${D}${EFI_BOOT_PATH}/boot-menu.inc${SB_FILE_EXT}" "${DEPLOYDIR}"
    [ x"${UEFI_SB}" = x"1" ] && {
        install -m 0600 "${D}${EFI_BOOT_PATH}/efi-secure-boot.inc" "${DEPLOYDIR}"
        install -m 0600 "${D}${EFI_BOOT_PATH}/password.inc" "${DEPLOYDIR}"
        install -m 0600 "${D}${EFI_BOOT_PATH}/efi-secure-boot.inc${SB_FILE_EXT}" "${DEPLOYDIR}"
        install -m 0600 "${D}${EFI_BOOT_PATH}/password.inc${SB_FILE_EXT}" "${DEPLOYDIR}"
    }

    install -d "${DEPLOYDIR}/efi-unsigned"
    install -m 0644 "${B}/${GRUB_IMAGE}" "${DEPLOYDIR}/efi-unsigned"
    PSEUDO_DISABLED=1 cp -af "${D}${EFI_BOOT_PATH}/${GRUB_TARGET}-efi" "${DEPLOYDIR}/efi-unsigned"
}

# override the do_chownboot
fakeroot do_chownboot() {
    chown root:root -R "${D}${EFI_BOOT_PATH}/grub.cfg${SB_FILE_EXT}"
    chown root:root -R "${D}${EFI_BOOT_PATH}/boot-menu.inc${SB_FILE_EXT}"
    [ x"${UEFI_SB}" = x"1" ] && {
        chown root:root -R "${D}${EFI_BOOT_PATH}/efi-secure-boot.inc${SB_FILE_EXT}"
        chown root:root -R "${D}${EFI_BOOT_PATH}/password.inc${SB_FILE_EXT}"
    }
}
