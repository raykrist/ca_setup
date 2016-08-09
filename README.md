# ca_setup
Simple setup to create your own CA

```
echo "mysecure_password" > passfile
./bootstrap.sh
./create_cachain.sh

./gen_server_cert.sh <host>
```
