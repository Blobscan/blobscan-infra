#!/bin/bash
set -e

cd /home/deploy/blobscan-indexer.rs
git pull
docker compose pull
docker compose stop indexer

sleep 10

cd /home/deploy/blobscan
git pull
docker compose pull
docker compose up -d api

cd /home/deploy/blobscan-indexer.rs
docker compose up -d indexer

docker image prune -f
