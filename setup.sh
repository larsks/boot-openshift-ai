#!/bin/sh

: ${DHCP_LEASE_TIME=6h}

OPTS_SPEC="\
${0##*/} -i provisioning_interface [-a provisioning_address] --dhcp-range begin,end [--dhcp-lease lease_time]

--
h,help
i,interface=INTERFACE     Provisioning interface
a,address=CIDR            Listen address as CIDR net/prefix
r,dhcp-range=RANGE        DHCP Range (begin,end)
l,dhcp-lease=LEASETIME    DHCP Lease time (default $DHCP_LEASE_TIME)
"

eval "$(git rev-parse --parseopt -- "$@" <<<$OPTS_SPEC || echo exit $?)"

while (( $# > 0 )); do
    case $1 in
    (-i)    PROVISIONING_INTERFACE=$2
            shift 2
            ;;

    (-a)    PROVISIONING_CIDR=$2
            shift 2
            ;;

    (-r)    DHCP_RANGE=$2
            shift 2
            ;;

    (-l)    DHCP_LEASE_TIME=$2
            shift 2
            ;;

    (--)    shift
            break
            ;;
    esac
done

if [ -z "$PROVISIONING_INTERFACE" ]; then
	echo "ERROR: missing PROVISIONING_INTERFACE" >&2
	exit 1
fi

if [ -z "$DHCP_RANGE" ]; then
	echo "ERROR: missing DHCP_RANGE" >&2
	exit 1
fi

if [ -z "$PROVISIONING_CIDR" ]; then
    PROVISIONING_CIDR=$(
        ip addr show $PROVISIONING_INTERFACE |
        awk '$1 == "inet" { print $2 }'
    )
fi

DHCP_RANGE_BEGIN=${DHCP_RANGE%,*}
DHCP_RANGE_END=${DHCP_RANGE#*,}
PROVISIONING_ADDRESS=${PROVISIONING_CIDR%/*}

sed '

s/PROVISIONING_ADDRESS/'"$PROVISIONING_ADDRESS"'/g

' grub.cfg.in > grub.cfg

cat > config.sh <<EOF
PROVISIONING_INTERFACE=$PROVISIONING_INTERFACE
PROVISIONING_ADDRESS=$PROVISIONING_ADDRESS
PROVISIONING_CIDR=$PROVISIONING_CIDR
DHCP_RANGE_BEGIN=$DHCP_RANGE_BEGIN
DHCP_RANGE_END=$DHCP_RANGE_END
DHCP_LEASE_TIME=$DHCP_LEASE_TIME
EOF
