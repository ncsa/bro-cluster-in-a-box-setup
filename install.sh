#!/usr/bin/env bash

ROOT=$(pwd)

source common.sh
source pfring.sh
source caf.sh
source bro.sh

pfring::setup
caf::setup 0.14.4
bro::setup v2.5.1 /srv/bro

source /etc/profile.d/bro.sh || barf

pfring::setup_bro_plugin

install_package net-tools # for ifconfig
bropkg::install_package ncsa/bro-interface-setup fix-multi
