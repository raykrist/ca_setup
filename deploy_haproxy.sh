#/bin/bash

function usage {
  echo ""
  echo "This will concat key, cert and ca into one file in /opt/repo/secrets"
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
pem_dest="${repo}/${host}/etc/pki/tls/certs/${cert}.pem"

# Dirs
mkdir -p "${repo}/${host}//etc/pki/tls/certs"

# key
key_source="intermediate/private/${cert}.key.pem"
cat $key_source > $pem_dest

# cert
cert_source="intermediate/certs/${cert}.cert.pem"
cat $cert_source >> $pem_dest

# CA
if [[ $cert == *"iaas.uib.no"* ]] || [[ $cert == *"iaas.uio.no"* ]] || [[ $cert == *"uh-iaas.no"* ]]; then
  ca='DigiCertCA.crt'
else
  ca='ca-chain.cert.pem'
fi

ca_source="intermediate/certs/${ca}"
cat $ca_source >> $pem_dest

echo "Created files:"
echo $pem_dest


