#!/bin/bash
set -e

cd /home/deploy/blobscan-indexer.rs
git pull
docker compose pull
docker compose up -d indexer
