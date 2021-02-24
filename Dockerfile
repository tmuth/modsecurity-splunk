FROM krish512/modsecurity
#COPY ./config/ .
COPY bash_profile.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/*.sh
#RUN apt-get update && apt-get install -y \
#   inetutils-ping netcat

RUN echo "export PATH=$PATH:/usr/local/nginx" >> ~/.bash_profile
RUN echo "alias reload='nginx -s reload'" >> ~/.bash_profile
RUN ln -s /etc/nginx/conf.d ~root/.
ARG foo=bar
#COPY config/nginx.conf /etc/nginx/nginx.conf
COPY nginx/splunk-nginx.conf /etc/nginx/conf.d/splunk-nginx.conf
COPY modsecurity/modsec-splunk.conf /etc/nginx/modsecurity.d/modsec-splunk.conf