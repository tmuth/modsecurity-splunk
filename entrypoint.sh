#!/bin/bash

set -e

# Start nginx if using entrypoint
nohup /usr/local/nginx/nginx &

export SPLUNK_HOME=/opt/splunkforwarder
echo -e '[user_info]\nUSERNAME = admin\nPASSWORD = welcome1' > /opt/splunkforwarder/etc/system/local/user-seed.conf


$SPLUNK_HOME/bin/./splunk start --accept-license
$SPLUNK_HOME/bin/./splunk add forward-server host.docker.internal:9997 -auth admin:welcome1
$SPLUNK_HOME/bin/./splunk install app /tmp/splunk-add-on-for-nginx_300.tgz -auth admin:welcome1
$SPLUNK_HOME/bin/./splunk install app /tmp/modsecurity-add-on-for-splunk_142.tgz -auth admin:welcome1

mkdir -p ${SPLUNK_HOME}/etc/apps/Splunk_TA_nginx/local
echo -e '[monitor:///var/log/nginx/splunk-access.log]\ndisabled = false\nsourcetype = nginx:plus:kv\nindex=nginx-kv' > ${SPLUNK_HOME}/etc/apps/Splunk_TA_nginx/local/inputs.conf
echo -e '\n\n[monitor:///var/log/nginx/splunk-error.log]\ndisabled = false\nsourcetype = nginx:plus:error\nindex=nginx-kv' >> ${SPLUNK_HOME}/etc/apps/Splunk_TA_nginx/local/inputs.conf

mkdir -p ${SPLUNK_HOME}/etc/apps/Splunk_TA_modsecurity/local
echo -e '[monitor:///var/log/modsec_audit.log]\nsourcetype = modsec:audit\nindex=modsecurity-audit' > ${SPLUNK_HOME}/etc/apps/Splunk_TA_modsecurity/local/inputs.conf

$SPLUNK_HOME/bin/./splunk restart

echo "************************"
echo "Splunk configured"
echo "************************"

#/bin/bash -c "trap : TERM INT; sleep infinity & wait"
tail -f /dev/null