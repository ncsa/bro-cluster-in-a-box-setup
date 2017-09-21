source epel.sh
source bropkg.sh
function pfring::setup() {
    if [ -e /usr/local/include/linux/pf_ring.h ]; then
        echo "PFRING already installed"
        return
    fi
    if [ ! -e /etc/yum.repos.d/ntop.repo ] ; then 
        curl  http://packages.ntop.org/centos/ntop.repo -o /etc/yum.repos.d/ntop.repo || barf
    fi;

   epel::setup
   yum update || barf
   yum -qy install pfring pfring-dkms || barf
}

function pfring::setup_bro_plugin() {
    bropkg::setup
    bro-pkg install https://github.com/ncsa/bro-pf_ring --version fix-load-balancing || barf
}
