#!/bin/bash
# Move custom data
if [ ! -d "/var/cloudbox/platform/_CUSTOM_" ]; then
	mv /customData/* /var/cloudbox/platform/;chown -R cloudmunch:cloudmunch /var/cloudbox/platform
fi
# Start httpd
httpd -DFOREGROUND
