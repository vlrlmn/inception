#!/bin/bash

CERT_DIR="$(dirname "$0")"
cd "$CERT_DIR"

openssl genrsa -out server.key 2048

openssl req -new -key server.key -out server.csr -config ssl.conf

openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

rm server.csr
