FROM krish512/modsecurity

RUN apt-get update && apt-get install -y \
   inetutils-ping netcat

RUN echo "export PATH=$PATH:/usr/local/nginx" >> ~/.bashrc
RUN echo "alias reload='nginx -s reload'" >> ~/.bashrc
RUN ln -s /etc/nginx/conf.d ~root/.
RUN ln -s /etc/nginx ~root/.

RUN ln -s /etc/nginx/conf.d/splunk-nginx.conf ~root/.
RUN ln -s /etc/nginx/modsecurity.d/modsec-splunk.conf ~root/.
#ARG foo=bar
#COPY config/nginx.conf /etc/nginx/nginx.conf
COPY nginx/splunk-nginx.conf /etc/nginx/conf.d/splunk-nginx.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
COPY modsecurity/modsec-splunk.conf /etc/nginx/modsecurity.d/modsec-splunk.conf

#ENV SHOME=
COPY splunk-binaries/* /tmp/
RUN apt install /tmp/splunkforwarder*.deb
RUN echo "export SPLUNK_HOME=/opt/splunkforwarder" >> ~/.bashrc
RUN echo 'export PATH=$PATH:${SPLUNK_HOME}/bin' >> ~/.bashrc
RUN echo 'alias shome="cd $SPLUNK_HOME"' >> ~/.bashrc
RUN echo -e '[user_info]\nUSERNAME = admin\nPASSWORD = welcome1' > /opt/splunkforwarder/etc/system/local/user-seed.conf

#ENTRYPOINT ["/sbin/entrypoint.sh"]
#CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

