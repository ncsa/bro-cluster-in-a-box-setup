function barf() {
    echo "Last command failed: $1";
    exit 1;
}

install_package() {
    rpm -q $1 > /dev/null || yum -qy install $1 || barf
}
