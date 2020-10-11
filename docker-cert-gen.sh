#!/bin/bash

SAN=${SAN:="DNS:localhost,IP:127.0.0.1"}
CA_CERTS_PATH=${CA_CERTS_PATH:="/certs/ca"}
CERTS_PATH=${CERTS_PATH:="/certs/out"}

echo Generating server-key.pem...
openssl genrsa \
  -out $CERTS_PATH/server-key.pem \
  4096

[ ! $? -eq 0 ] && echo "An error occurred while generating server-key.pem" && exit 1;

echo Generating CSR...
openssl req \
  -sha256 \
  -new \
  -key $CERTS_PATH/server-key.pem \
  -subj "/C=AU" \
  -out /tmp/server.csr

[ ! $? -eq 0 ] && echo "An error occurred while generating a CSR" && exit 1;

echo Generating server.pem...
echo subjectAltName = $SAN >> extfile.cnf
echo extendedKeyUsage = serverAuth >> extfile.cnf
openssl x509 \
  -req \
  -days 365 \
  -sha256 \
  -in /tmp/server.csr \
  -CA $CA_CERTS_PATH/ca.pem \
  -CAkey $CA_CERTS_PATH/ca-key.pem \
  -CAcreateserial \
  -CAserial /tmp/ca.seq \
  -extfile extfile.cnf \
  -out $CERTS_PATH/server.pem 

if [ $? -eq 0 ]; then
  echo "Success."
  echo "Generated the following cert & key:"
  echo $CERTS_PATH/server.pem
  echo $CERTS_PATH/server-key.pem
else
  echo "An error occurred"
  exit 1
fi
