#!/bin/bash

OCP_VERSION="4.7.44"

read -p "***OCP lient tool version is $OCP_VERSION. CTRL+C to exit***"

mkdir ~/.local/bin/

TMPDIR=$(mktemp -d)
URL_OCP_CLIENT="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/"$OCP_VERSION"/openshift-client-linux.tar.gz"
URL_OCP_INSTALL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/"$OCP_VERSION"/openshift-install-linux.tar.gz"

curl $URL_OCP_CLIENT -o "$TMPDIR/openshift-client-linux.tar.gz"
curl $URL_OCP_CLIENT -o "$TMPDIR/openshift-install-linux.tar.gz"

tar xavf "$TMPDIR/openshift-client-linux.tar.gz" --directory "$TMPDIR"
tar xavf "$TMPDIR/openshift-install-linux.tar.gz" --directory "$TMPDIR"

mv "$TMPDIR"/{oc,kubectl,openshift-install} ~/.local/bin/

rm -rfv "$TMPDIR"

#EOF