#!/bin/bash

if [ $# -eq 0 ] 
then
	echo "Usage: ./sign-csr.sh <PATH_TO_CSR>"
	exit 0
fi

touch conf/index.txt

echo ${RANDOM:0:2} > conf/serial.txt

openssl ca -config conf/ca.conf -policy signing_policy -extensions signing_req -out server-cert-store/Signed-Cert.pem -infiles $1

openssl x509 -in server-cert-store/Signed-Cert.pem -outform PEM -out server-cert-store/Signed-Cert.pem

rm conf/serial.txt

echo "x.509 Certificate created successfully! Find it in 'server-cert-store' directory."
