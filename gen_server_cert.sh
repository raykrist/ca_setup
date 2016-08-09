#/bin/bash

if [ ! -f "./passfile" ]; then
  echo "Please create a file called ./passfile with a secure password"
  exit 1
fi

host=$1
cnf="cnf/${host}.cnf"

if [ -f "cnf/${host}.cnf" ]; then
  cnf="cnf/${host}.cnf"
else
  cnf="intermediate/openssl.cnf"
fi

echo "Using ${cnf} as config file"

openssl genrsa -out intermediate/private/${host}.key.pem 2048


openssl req -config ${cnf} -key intermediate/private/${host}.key.pem -new -sha256 -out intermediate/csr/${host}.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions v3_req \
  -days 375 -notext -md sha256 -in intermediate/csr/${host}.csr.pem \
  -passin file:passfile \
  -out intermediate/certs/${host}.cert.pem
