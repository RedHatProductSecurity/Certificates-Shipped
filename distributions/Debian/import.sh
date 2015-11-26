#!/bin/sh

set -eu

URL="${1}"
DISTRIBUTION="${2}"

TEMP="$(mktemp -d)"
trap "rm -rf ${TEMP}" EXIT

TARGET="${DISTRIBUTION}/$(basename "${URL}")"
mkdir -p ${TARGET}

wget -O ${TEMP}/temp.deb "${URL}"
dpkg-deb -x "${TEMP}/temp.deb" ${TARGET}

find ${TARGET} -type f -not -name '*.crt' -delete
rm -rf ${TARGET}/usr/share/doc/ca-certificates/examples
find ${TARGET} -type d -empty -delete
