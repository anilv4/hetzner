#!/bin/bash

read "*** Do you want to remove bind? CTRL+C to exit ***"

systemctl disable bind
systemctl disable named
systemctl stop named
dnf remove bind bind-utils -y
rm -rfv /etc/named.conf /etc/named.conf.rpmsave /var/named/
