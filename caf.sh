function caf::setup() {
    ver=$1
    STATE_FILE=/usr/local/CAF_INSTALLED_VERSION
    if [ -e $STATE_FILE ] && grep -wq $ver $STATE_FILE ; then
        echo "caf ${ver} already installed"
        return
    fi

    yum install -y git cmake cmake28 make gcc gcc-c++ openssl-devel python-devel swig

    cd /usr/src
    curl -L https://github.com/actor-framework/actor-framework/archive/${ver}.tar.gz -o caf-${ver}.tar.gz || barf
    tar xzf caf-${ver}.tar.gz || barf
    rm caf-${ver}.tar.gz

    cd actor-framework-${ver} && ./configure --prefix=/usr/local && make install || barf
    cd ..
    rm -rf actor-framework-${ver}
    echo $ver > $STATE_FILE
}
