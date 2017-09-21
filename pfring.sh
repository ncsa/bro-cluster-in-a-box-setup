source epel.sh
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
