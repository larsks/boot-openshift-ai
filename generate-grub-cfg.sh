#!/bin/sh

. ./config.sh

sed '

s/PROVISIONING_ADDRESS/'"$PROVISIONING_ADDRESS"'/g

' grub.cfg.in > grub.cfg

