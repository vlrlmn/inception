FROM alpine:3.20

ARG DOMAIN_NAME SSL_CER SSL_KEY

RUN apk add --no-cache nginx openssl && rm -rf /var/cache/apk/*

EXPOSE 443

COPY /tools/run.sh /usr/local/bin/run.sh

CMD ["/bin/sh", "/usr/local/bin/run.sh"]
