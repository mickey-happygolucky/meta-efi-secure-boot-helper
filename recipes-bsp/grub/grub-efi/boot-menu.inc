menuentry "Sample EFI boot" --unrestricted {
    savedefault
    set fallback=1
    linux /bzImage root=/dev/sda2 ro rootwait
}