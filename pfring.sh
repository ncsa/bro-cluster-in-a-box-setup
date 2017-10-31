source epel.sh
source bropkg.sh

function pfring::setup_userland() {
    if [ -e /usr/local/include/linux/pf_ring.h ]; then
        echo "PFRING userland already installed"
        return
    fi
    if [ ! -e /etc/yum.repos.d/ntop.repo ] ; then 
        curl  http://packages.ntop.org/centos/ntop.repo -o /etc/yum.repos.d/ntop.repo || barf
    fi;

   epel::setup
   yum update || barf
   yum -q -y install pfring || barf
}

function pfring::setup_kernel() {
   install_package kernel-devel
   yum -q -y install pfring-dkms || barf
}

function pfring::setup() {
    pfring::setup_userland
    pfring::setup_kernel

    if [ ! -e /etc/modprobe.d/pfring_options.conf ]; then
        cp ${ROOT}/dist/pfring_options.conf /etc/modprobe.d/
    fi
    ldconfig
}

function pfring::setup_bro_plugin() {
    bropkg::install_package https://github.com/ncsa/bro-pf_ring fix-load-balancing || barf
}
