#!/bin/bash

## change directory to script directory.
## this is required because of the template files.
cd $(dirname $0)

## vars

LISTEN_IP=192.168.200.2
ALLOW_QUERY_IP="192.168.200.0"
ALLOW_QUERY_SUBNET="24"
FORWARDERS_IPS="1.1.1.1"
IP_HEADER="192.168.200"
REVERSE_IP_HEADER="200.168.192"
MASTER_DOMAIN="example.com"
NAMED_CONF_TEMPLATE="templates/named-conf.template"
DB_DOMAIN_TEMPLATE="templates/domain-db.template"
REVERSE_DB_DOMAIN_TEMPLATE="templates/domain-reverse-db.template"
TMPDIR="$(mktemp -d)"

## subdomain is optional. if needed always use with a dot.
## for example ".ocp4"

SUBDOMAIN='.ocp4'

## EO vars

## install named

dnf install bind bind-utils -y

## named.conf replacements

sed -e "s/LISTEN_IP/$LISTEN_IP/g; \
s/ALLOW_QUERY_IP/$ALLOW_QUERY_IP/g; \
s/ALLOW_QUERY_SUBNET/$ALLOW_QUERY_SUBNET/g; \
s/FORWARDERS_IPS/$FORWARDERS_IPS/g; \
s/REVERSE_IP_HEADER/$REVERSE_IP_HEADER/g; \
s/MASTER_DOMAIN/$MASTER_DOMAIN/g;" "$NAMED_CONF_TEMPLATE" > "$TMPDIR/named.conf"

## domain.db replacements
sed -e "s/MASTER_DOMAIN/$MASTER_DOMAIN/g; \
s/IP_HEADER/$IP_HEADER/g; \
s/SUBDOMAIN/$SUBDOMAIN/g" "$DB_DOMAIN_TEMPLATE" > "$TMPDIR/$MASTER_DOMAIN.db"

## reverse.db replacements
sed -e "s/MASTER_DOMAIN/$MASTER_DOMAIN/g; \
s/SUBDOMAIN/$SUBDOMAIN/g" "$REVERSE_DB_DOMAIN_TEMPLATE" > "$TMPDIR/$MASTER_DOMAIN.reverse.db"
## EO replacements

## copy files
ls -l "$TMPDIR"/*
cp -v "$TMPDIR/named.conf" /etc/named.conf
cp -v "$TMPDIR/$MASTER_DOMAIN.db" /var/named/db.$MASTER_DOMAIN
cp -v "$TMPDIR/$MASTER_DOMAIN.reverse.db" /var/named/db.reverse.$MASTER_DOMAIN
rm -rfv "$TMPDIR"
# EO copy files


## Enable and start the service named
systemctl enable named
systemctl restart named
systemctl status named
##



#EOF