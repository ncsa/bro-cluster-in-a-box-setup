function bropkg::setup() {
    if [ ! -e /usr/bin/pip ]; then
        yum -qy install python2-pip || barf
    fi
    if [ -e /usr/bin/bro-pkg ]; then
        return
    fi
    pip install bro-pkg || barf
    bro-pkg autoconfig
}

function bropkg::install_package() {
    bropkg::setup
    bro-pkg list installed | grep -qw $1 && return 
    bro-pkg install $1
}
