#!/bin/sh

exec dnsmasq -d -i provisioning \
	--dhcp-range=172.22.3.10,172.22.3.250,6h \
	--enable-tftp \
	--tftp-root=$PWD \
	--log-dhcp \
	--dhcp-authoritative \
	--dhcp-option=3 \
	-M grubx64.efi \
	> dnsmasq.log 2>&1
