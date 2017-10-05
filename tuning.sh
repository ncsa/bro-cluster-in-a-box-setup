function tuning::setup {
    if [ ! -e /etc/modprobe.d/ixgb.conf ]; then
        cp ${ROOT}/dist/ixgb.conf /etc/modprobe.d/
    fi
}
