#/bin/bash

openssl genrsa -out intermediate/private/www.example.com.key.pem 2048

openssl req -config server.cnf -key intermediate/private/www.example.com.key.pem -new -sha256 -out intermediate/csr/www.example.com.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions v3_req \
  -days 375 -notext -md sha256 -in intermediate/csr/www.example.com.csr.pem \
  -out intermediate/certs/www.example.com.cert.pem -noemailDN
