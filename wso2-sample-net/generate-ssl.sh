#!/usr/bin/env bash

# Specify where we will install
# the docker.local certificate
SSL_DIR="./crt"

# Set the wildcarded domain
# we want to use
DOMAIN="*.docker.local"

# A blank passphrase
PASSPHRASE=""

# Set our CSR variables
SUBJ="
C=UA
ST=
O=ELEKS
localityName=
commonName=$DOMAIN
organizationalUnitName=
emailAddress=
"

# Create our SSL directory
# in case it doesn't exist
mkdir -p "$SSL_DIR"

# Generate our Private Key, CSR and Certificate
openssl genrsa -out "$SSL_DIR/docker.local.key" 2048
openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "$SSL_DIR/docker.local.key" -out "$SSL_DIR/docker.local.csr" -passin pass:$PASSPHRASE
openssl x509 -req -days 365 -in "$SSL_DIR/docker.local.csr" -signkey "$SSL_DIR/docker.local.key" -out "$SSL_DIR/docker.local.crt"
