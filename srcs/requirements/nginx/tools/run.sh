#!/bin/sh

if [ ! -f /etc/self-signed.crt ]; then
    openssl \
        req -x509 \
        -nodes \
        -subj "/CN=${DOMAIN_NAME}}" \
        -addext "subjectAltName=DNS:${DOMAIN_NAME}" \
        -days 365 \
        -newkey rsa:2048 -keyout /etc/self-signed.key \
        -out /etc/self-signed.crt
fi

echo "server {
    listen 443 ssl;
    server_name _;
    root /var/www/html/wordpress;
    index index.php;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_certificate $SSL_CER;
    ssl_certificate_key $SSL_KEY;
    location / {
        try_files \$uri /index.php?\$args;
        add_header Last-Modified \$date_gmt;
        add_header Cache-Control 'no-store, no-cache';
        if_modified_since off;
        expires off;
        etag off;
    }
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
    }
}" > /etc/nginx/http.d/default.conf

mkdir -p /run/nginx;
nginx -g 'daemon off;'
