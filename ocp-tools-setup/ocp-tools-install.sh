#!/bin/bash
OCP_VERSION="4.7.44"

TMPDIR=$(mkdir -d)
URL_OCP_CLIENT="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/"$OCP_VERSION"/openshift-client-linux.tar.gz"

curl $URL_OCP_CLIENT -o "$TMPDIR/openshift-client-linux.tar.gz"