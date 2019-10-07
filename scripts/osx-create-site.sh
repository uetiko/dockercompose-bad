#!/bin/bash
set -x

mkdir -p /etc/ssl/certs/local/${HOST_NAME}/


openssl genrsa -des3 \
        -out /etc/ssl/certs/local/${HOST_NAME}/$1.key 4096

openssl rsa \
        -in /etc/ssl/certs/local/${HOST_NAME}/$1.key \
        -out /etc/ssl/certs/local/${HOST_NAME}/$1.pem

openssl req -new \
        -key /etc/ssl/certs/local/${HOST_NAME}/$1.key \
        -out /etc/ssl/certs/local/${HOST_NAME}/$1.csr

openssl x509 -req -days 365 \
    -in /etc/ssl/certs/local/${HOST_NAME}/$1.csr \
    -signkey /etc/ssl/certs/local/${HOST_NAME}/$1.key \
    -out /etc/ssl/certs/local/${HOST_NAME}/$1.crt

cp /etc/apache2/sites-available/virtualhost.conf \
    /etc/apache2/sites-available/$1.virtualhost.conf

cp /etc/apache2/sites-available/virtualhostssl.conf \
    /etc/apache2/sites-available/$1.virtualhostssl.conf

sed -i -e "s/host_name/${HOST_NAME}/g" \
    /etc/apache2/sites-available/$1.virtualhost.conf

sed -i -e "s/host_name/${HOST_NAME}/g" \
    /etc/apache2/sites-available/$1.virtualhostssl.conf

sed -i -e "s/domain/$1/g" \
    /etc/apache2/sites-available/$1.virtualhost.conf

sed -i -e "s/domain/$1/g" \
    /etc/apache2/sites-available/$1.virtualhostssl.conf

ln -s /etc/apache2/sites-available/$1.virtualhost.conf \
    /etc/apache2/sites-enabled/$1.virtualhost.conf

ln -s /etc/apache2/sites-available/$1.virtualhostssl.conf \
    /etc/apache2/sites-enabled/$1.virtualhostssl.conf

apachectl restart
