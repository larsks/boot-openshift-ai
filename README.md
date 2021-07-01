# Net boot the openshift assisted installer

- Extract images from the ISO using [`extract-iso.sh`](extract-iso.sh)
- Provide [grub](grubx64.efi) and a [configuration file](grub.cfg).
- [Run a webserver](run-webserver.sh)
- [Run dnsmasq](run-dnsmasq.sh)

There's a [`setup.sh`](setup.sh) script to help set things up.
