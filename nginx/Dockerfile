FROM nginx
MAINTAINER Timothy Hnat twhnat@memphis.edu

RUN apt-get update && \
    apt-get install curl && \
    rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY *.crt /etc/nginx/
COPY *.key /etc/nginx/

HEALTHCHECK --interval=5m --timeout=3s \
CMD curl -f http://localhost/ || exit 1

VOLUME /var/www /etc/ssh/certs/ssl-cert.crt /etc/ssh/certs/ssl-cert.key
