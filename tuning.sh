function tuning::setup {
    if [ ! -e /etc/modprobe.d/ixgbe.conf ]; then
        cp ${ROOT}/dist/ixgbe.conf /etc/modprobe.d/
    fi

    if ! grep -q nohz_full /etc/default/grub; then
        echo "Appending nohz_full=1-19,21-39 isolcpus=1-15,17-31 to kernel commandline"
        perl -pi.back -e 's/quiet"/quiet nohz_full=1-19,21-39 isolcpus=1-19,21-39"/' /etc/default/grub
        echo "Rebuilding initrd"
        /sbin/grub2-mkconfig -o /boot/grub2/grub.cfg
    fi
}
