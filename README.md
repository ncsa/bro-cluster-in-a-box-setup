# Cluster in a box setup

## Usage

    ./install.sh

## Post install

change MailTo in /srv/bro/etc/broctl.cfg

Add local networks to /srv/bro/etc/networks.cfg

reboot if first run, or run `broctl deploy` otherwise
