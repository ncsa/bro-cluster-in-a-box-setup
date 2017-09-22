#!/bin/bash -e

REPO=git://git.bro.org/bro

function die {
    echo $*
    exit 1
}

function install_prereqs {
    yum install -q -y git cmake cmake28 make gcc gcc-c++ flex bison libpcap-devel openssl-devel python-devel swig gperftools-devel GeoIP-devel
}

function checkout_version {
    VERSION=$1
    git fetch
    git checkout -f $VERSION
    git submodule update --recursive -f || git submodule update --recursive
}

function install_bro {
    VERSION=$1
    PREFIX=$2
    STATE_FILE=$PREFIX/INSTALLED_VERSION
    if [ -e $STATE_FILE ] && grep -wq $VERSION $STATE_FILE ; then
        echo "bro ${VERSION} already installed"
        return
    fi

    install_prereqs

    cd /usr/src
    if [ ! -e bro ] ; then
        git clone --recursive $REPO
    fi

    cd bro
    checkout_version $VERSION

    pcap=""
    #if [ -e /opt/snf ]; then
    #    pcap="--with-pcap=/opt/snf"
    #fi
    #if [ -e /opt/pfring ] ; then
    #    pcap="--with-pcap=/opt/pfring"
    #fi
    pcap="--with-pcap=/usr"

    broker=""
    if grep -q -- --enable-broker configure ; then
        broker="--enable-broker"
    fi

    mkdir -p /usr/local/lib/tmp #HACK
    mv /usr/local/lib/libpcap* /usr/local/lib/tmp #HACK

    ./configure --prefix=$PREFIX $pcap $malloc $broker || die "configure failed"

    mv /usr/local/lib/tmp/* /usr/local/lib/ #HACK

    make -j 8 -l 8 || die "build failed"
    make install || die "install failed"

    echo $VERSION > $STATE_FILE

    $PREFIX/bin/broctl install || die "broctl install failed"
}

function bro::setup {
    if [[ $# -ne 2 ]]; then
        echo "Usage $0 version installation_prefix"
        exit 1
    fi
    VERSION=$1
    PREFIX=$2
    echo "Installing bro $VERSION in $PREFIX"
    install_bro $VERSION $PREFIX

    if [ ! -e /etc/profile.d/bro ]; then
        cp ${ROOT}/dist/bro_profile.sh /etc/profile.d/bro.sh
    fi
    if [ ! -e /etc/systemd/system/bro.service ]; then
        cp ${ROOT}/dist/bro.service /etc/systemd/system/bro.service
        systemctl enable bro
    fi
}

