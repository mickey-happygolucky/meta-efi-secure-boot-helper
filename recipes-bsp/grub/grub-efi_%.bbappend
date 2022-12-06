FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# to avoid the installing the grubx64.efi that is not certified.
do_deploy() {
}
