#/bin/bash
BLOBSCAN_DIR=$HOME/blobscan
BLOBSCAN_IDX_DIR=$HOME/blobscan-indexer.rs

blobscan-check-blocks() {
  while true; do echo "$(date)| $(cast block-number)"; sleep 300; done
}

blobscan-sql() {
	source $HOME/blobscan/.env
	docker run -ti --rm postgres:15 psql $DATABASE_URL
}

alias propagator='docker compose exec api pnpm propagator'

blobscan-up() {
  cd $BLOBSCAN_DIR
  docker compose up -d
}

blobscan-stop() {
  cd $BLOBSCAN_DIR
  docker compose stop
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

indexer-up() {
  cd $BLOBSCAN_IDX_DIR
  docker compose up -d
}

indexer-stop() {
  cd $BLOBSCAN_IDX_DIR
  docker compose stop
}

indexer-logs() {
  cd $BLOBSCAN_IDX_DIR
  docker compose logs -f --tail=100 $@
}

alias wfree="watch free -m"
alias dc="docker compose"
