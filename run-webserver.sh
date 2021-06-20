#!/bin/sh

exec podman run --rm --name web \
	-p 80:8080 \
	-v $PWD:/var/www/localhost/htdocs:Z \
	alpinelinux/darkhttpd > web.log 2>&1
