#!/bin/sh

. ./config.sh

exec dnsmasq -d \
	-i $PROVISIONING_INTERFACE \
	--bind-interfaces \
	--dhcp-range=$DHCP_RANGE_BEGIN,$DHCP_RANGE_END,$DHCP_LEASE_TIME \
	--enable-tftp \
	--tftp-root=$PWD \
	--log-dhcp \
	--dhcp-authoritative \
	--dhcp-option=3 \
	-M grubx64.efi \
	$DNSMASQ_OPTIONS \
	> dnsmasq.log 2>&1
