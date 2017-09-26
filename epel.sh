source common.sh
function epel::setup() {
    if [  -e /etc/yum.repos.d/epel.repo ] ; then
        echo "EPEL already installed"
        return
    fi
    install_package epel-release
}
