FROM nginx
MAINTAINER Timothy Hnat twhnat@memphis.edu

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY *.conf /etc/nginx/
COPY *.crt /etc/nginx/
COPY *.key /etc/nginx/

HEALTHCHECK --interval=1m --timeout=3s --start-period=30s \
CMD curl -f http://localhost/ || exit 1

VOLUME /var/www /etc/ssh/certs/ssl-cert.crt /etc/ssh/certs/ssl-cert.key
