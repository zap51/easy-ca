#!/bin/bash

openssl ecparam -genkey -name prime256v1 | openssl ec -out ca-store/CA-Key.pem

cp conf/ca.conf conf/ca.conf.orig

read -p "(Required) Enter Country [eg. US]: " c
read -p "(Required) Enter Organization Name: " o
read -p "(Required) Enter Common Name: " cn

echo "[req_distinguished_name]
C  = $c
O  = $o
CN = $cn " | tee -a conf/ca.conf

openssl req -new -sha256 -config conf/ca.conf -key ca-store/CA-Key.pem -outform PEM -out ca-store/CA-CSR.pem

openssl x509 -signkey ca-store/CA-Key.pem -req -in ca-store/CA-CSR.pem -extensions v3_ca -extfile conf/ca.conf -days 10000 -outform PEM -out ca-store/CA-Cert.pem

echo "CA Created Successfully!"

echo "That CA will be used for all operations."

rm ca-store/CA-CSR.pem

mv conf/ca.conf.orig conf/ca.conf
