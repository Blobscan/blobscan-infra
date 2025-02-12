#!/bin/bash
set -ex

PG_DUMP="docker run --rm postgres:16 pg_dump"

TODAY=$(date -I)
NETWORK={{ network }}
ENV={{ env }}

source blobscan/.env

# Note: DATABASE_DIRECT_URL must use the doadmin user
$PG_DUMP -v -Fc "$DATABASE_DIRECT_URL" > $HOME/${ENV}_${NETWORK}_${TODAY}.psql
