#!/bin/bash

OCP_VERSION="4.7.44"

read -p "***OCP client tool version is $OCP_VERSION. CTRL+C to exit***"

#RHEL8
BINDIR="$HOME/bin"

#Fedora
#BINDIR="$HOME/.local/bin"

mkdir -pv $BINDIR

TMPDIR=$(mktemp -d)

URL_OCP_CLIENT="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/"$OCP_VERSION"/openshift-client-linux.tar.gz"
URL_OCP_INSTALL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/"$OCP_VERSION"/openshift-install-linux.tar.gz"

curl $URL_OCP_CLIENT -o "$TMPDIR/openshift-client-linux.tar.gz"
curl $URL_OCP_INSTALL -o "$TMPDIR/openshift-install-linux.tar.gz"

tar xavf "$TMPDIR/openshift-client-linux.tar.gz" --directory "$TMPDIR"
tar xavf "$TMPDIR/openshift-install-linux.tar.gz" --directory "$TMPDIR"

ls $TMPDIR/{oc,kubectl,openshift-install}

mv -v $TMPDIR/{oc,kubectl,openshift-install} $BINDIR

rm -rfv $TMPDIR

#EOF