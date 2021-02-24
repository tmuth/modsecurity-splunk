#!/bin/bash

set -e
export SPLUNK_HOME=/opt/splunkforwarder
echo -e '[user_info]\nUSERNAME = admin\nPASSWORD = welcome1' > /opt/splunkforwarder/etc/system/local/user-seed.conf
#$SPLUNK_HOME/bin/./splunk start --accept-license
#$SPLUNK_HOME/bin/./splunk add forward-server host.docker.internal:8089 -auth admin:welcome1
#$SPLUNK_HOME/bin/./splunk install app /tmp/splunk-add-on-for-nginx_300.tgz -auth admin:welcome1
#/bin/bash -c "trap : TERM INT; sleep infinity & wait"