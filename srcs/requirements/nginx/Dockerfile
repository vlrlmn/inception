FROM alpine:3.20

ARG DOMAIN_NAME SSL_CER SSL_KEY

RUN apk add --no-cache nginx openssl && rm -rf /var/cache/apk/*

COPY /tools/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 443
CMD ["/bin/sh", "/usr/local/bin/run.sh"]
