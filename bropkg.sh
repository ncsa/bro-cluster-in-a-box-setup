function bropkg::setup() {
    if [ ! -e /usr/bin/pip ]; then
        yum -y install python2-pip || barf
    fi
    if [ -e ~/.bro-pkg/config ]; then
        return
    fi
    if ! python -c 'import configparser' 2>/dev/null ; then
        pip install configparser || barf
    fi
    pip install bro-pkg || barf
    bro-pkg autoconfig
}

function bropkg::install_package() {
    pkg=$1
    ver=$2
    bropkg::setup
    if bro-pkg list installed | grep -w $pkg | grep -qw $ver ; then
        echo "bro package $pkg version $ver already installed"
        return;
    fi
    echo "Installing bro package $pkg version $ver"
    bro-pkg refresh
    bro-pkg install $pkg --version $ver  || barf
}
