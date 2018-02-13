function barf() {
    echo "Last command failed: $1";
    exit 1;
}

install_package() {
    if rpm -q $1 > /dev/null ; then
        return
    fi
    echo "Installing package $1"
    yum -y install $1 || barf
}
