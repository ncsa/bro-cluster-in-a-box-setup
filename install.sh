#!/usr/bin/env bash

ROOT=$(pwd)

source common.sh
source pfring.sh
source caf.sh
source bro.sh
source tuning.sh

pfring::setup
caf::setup 0.14.4
bro::setup v2.5.1 /srv/bro

source /etc/profile.d/bro.sh || barf

pfring::setup_bro_plugin

install_package net-tools # for ifconfig
install_package gdb # for crash reports

bropkg::install_package ncsa/bro-interface-setup master
bropkg::install_package ncsa/bro-doctor 1.17.0

tuning::setup

if [ $(readlink /etc/localtime) != "/usr/share/zoneinfo/UTC" ] ; then
    echo "Setting timezone to UTC"
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime
fi
