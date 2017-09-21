source common.sh
function epel::setup() {
    if [  -e /etc/yum.repos.d/epel.repo ] ; then
        echo "EPEL already installed"
        return
    fi
    yum -qy install epel-release || barf

}
