#!/usr/bin/env bash

set

source common.sh
source pfring.sh
source caf.sh
source bro.sh

pfring::setup
caf::setup 0.14.4
bro::setup v2.5.1 /usr/local/bro

source /etc/profile.d/bro.sh

pfring::setup_bro_plugin
