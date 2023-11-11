#/bin/bash
BLOBSCAN_DIR=$HOME/blobscan

blobscan-check-blocks() {
  while true; do echo "$(date)| $(cast block-number)"; sleep 300; done
}

blobscan-up() {
  cd $BLOBSCAN_DIR
  docker compose up -d api indexer
}

blobscan-resetdb() {
  cd $BLOBSCAN_DIR
  docker compose stop indexer
  docker compose exec api npx prisma migrate reset --schema packages/db/prisma/schema.prisma
  docker compose down -v
  docker compose up -d
}

blobscan-logs() {
  cd $BLOBSCAN_DIR
  docker compose logs -f --tail=100 $@
}

blobscan-stop() {
  cd $BLOBSCAN_DIR
  docker compose stop
}

alias wfree="watch free -m"
alias dc="docker compose"
