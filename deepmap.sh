#!/bin/bash

set -euo pipefail

ROOT=${BASH_SOURCE[0]}
ROOT=$(realpath "$ROOT")
ROOT=$(dirname "$ROOT")

function help {
    echo "$0: <openapi specification file>" 1>&2
    exit 1
}

if [ $# -ne 1 ]; then
    help
fi

OPENAPI=$1
NAME=$(basename "${OPENAPI}" .yaml)
GOLANG=${ROOT}/${NAME}/api.go

mkdir -p "${ROOT}/${NAME}"
go run github.com/deepmap/oapi-codegen/v2/cmd/oapi-codegen@v2.1.0 \
    -config config.yaml -package "${NAME}" -o "$GOLANG" "$OPENAPI"
gofmt -w "$GOLANG"
