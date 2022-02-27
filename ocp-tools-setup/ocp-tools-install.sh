#!/bin/bash
OCP_VERSION="4.7.44"

read -p "***OCP lient tool version is $OCP_VERSION. CTRL+C to exit***"

TMPDIR=$(mktemp -d)
URL_OCP_CLIENT="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/"$OCP_VERSION"/openshift-client-linux.tar.gz"

curl $URL_OCP_CLIENT -o "$TMPDIR/openshift-client-linux.tar.gz"