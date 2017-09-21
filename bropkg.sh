function bropkg::setup() {
    if [ ! -e /usr/bin/pip ]; then
        yum -qy install python2-pip || barf
    fi
    if [ -e /usr/local/bin/bro-pkg ]; then
        return
    fi
    pip install -y bro-pkg || barf
}
