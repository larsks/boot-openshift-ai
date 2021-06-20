#!/bin/sh

discovery_iso=$1

[ -f "$discovery_iso" ] || exit 1

mkdir images
isoinfo -i $discovery_iso -x '/IMAGES/IGNITION.IMG;1' | zcat | cpio -ivd
isoinfo -i $discovery_iso -x '/IMAGES/PXEBOOT/INITRD.IMG;1' > images/initrd.img
isoinfo -i $discovery_iso -x '/IMAGES/PXEBOOT/ROOTFS.IMG;1' > images/rootfs.img
isoinfo -i $discovery_iso -x '/IMAGES/PXEBOOT/VMLINUZ.;1' > images/vmlinuz
