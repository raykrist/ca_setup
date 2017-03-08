#/bin/bash

function usage {
  echo ""
  echo "This will deploy key, cert and ca to /opt/repo/secrets"
  echo "${0} <certname> <host>"
  echo ""
  exit 1
}

if [ $# -ne 2 ]; then
  usage
fi

cert=$1
host=$2
repo="${HOME}/dev/local/repo/secrets/nodes"

# Dirs
mkdir -p "${repo}/${host}//etc/pki/tls/certs"
mkdir -p "${repo}/${host}//etc/pki/tls/private"

# CA
if [[ $cert == *"iaas.uib.no"* ]] || [[ $cert == *"iaas.uio.no"* ]] || [[ $cert == *"uh-iaas.no"* ]]; then
  ca='DigiCertCA.crt'
else
  ca='ca-chain.cert.pem'
fi

ca_source="intermediate/certs/${ca}"
ca_dest="${repo}/${host}/etc/pki/tls/certs/cachain.pem"

cp -f $ca_source $ca_dest

# Cert
cert_source="intermediate/certs/${cert}.cert.pem"
cert_dest="${repo}/${host}/etc/pki/tls/certs/${cert}.cert.pem"
cp -f $cert_source $cert_dest

# key
key_source="intermediate/private/${cert}.key.pem"
key_dest="${repo}/${host}/etc/pki/tls/private/${cert}.key.pem"
cp -f $key_source $key_dest

echo "Created files:"
echo $ca_dest
echo $cert_dest
echo $key_dest


