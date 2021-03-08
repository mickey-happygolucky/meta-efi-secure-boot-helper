FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# avoid the installing grubx64.efi which does not certified.
do_deploy() {
}
