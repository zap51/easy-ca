#!/bin/bash

openssl ecparam -genkey -name prime256v1 | openssl ec -out server-private-key.pem

echo " [ req ]
prompt=yes
distinguished_name = req_distinguished_name

# Uncomment and edit the [ san ] section to add SAN fields.
# req_extensions = san

[ req_distinguished_name ]
countryName                 = Country Name (2 letter code)
stateOrProvinceName         = State or Province Name (full name)
localityName               = Locality Name (eg, city)
organizationName           = Organization Name (eg, company)
commonName                 = Common Name (e.g. server FQDN or YOUR name)

[ san ]
subjectAltName = @alt_names
		[alt_names]
		DNS.1 = example.com
		DNS.2 = localhost
		IP.1 = 127.0.0.1 " | tee conf/server.conf

openssl req -new -sha256 -key server-private-key.pem -nodes -outform PEM -out server-csr.pem -config conf/server.conf

rm conf/server.conf

echo "CSR generated successfully."

echo " Verify using 'openssl req -in server-csr.pem -text -noout' "
