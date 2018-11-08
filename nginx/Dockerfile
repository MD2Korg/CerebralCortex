FROM nginx
MAINTAINER Timothy Hnat twhnat@memphis.edu

COPY nginx.conf /etc/nginx/nginx.conf
COPY *.crt /etc/nginx/
COPY *.key /etc/nginx/

VOLUME /var/www /etc/ssh/certs/ssl-cert.crt /etc/ssh/certs/ssl-cert.key
