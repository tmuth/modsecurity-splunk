# modsecurity-splunk
Creates an nginx reverse proxy server with modsecurity icluded. Rules in modsec-splunk.conf will prevent the datamodel and tstats commands.

## Installation
- docker pull krish512/modsecurity
- docker build -t modsec-splunk . --no-cache
- docker run -p 8081:8080 modsec-splunk
