resource "digitalocean_database_cluster" "blobscan" {
  name         = "blobscan-${var.network}-${var.env}"
  engine       = "pg"
  version      = "16"
  size         = "${var.database_size}"
  storage_size_mib = 61440
  region       = "${var.do_region}"
  node_count   = 1
  tags         = ["blobscan", "${var.env}", "${var.network}"]
}

resource "digitalocean_database_cluster" "blobscan_redis" {
  name       = "blobscan-redis-${var.network}-${var.env}"
  engine     = "redis"
  version    = "7"
  size       = "db-s-1vcpu-1gb"
  region     = "${var.do_region}"
  node_count = 1
  tags         = ["blobscan", "${var.env}", "${var.network}"]
}


output "db_host" {
 value = "${digitalocean_database_cluster.blobscan.host}"
}

output "db_port" {
 value = "${digitalocean_database_cluster.blobscan.port}"
}

output "redis_host" {
 value = "${digitalocean_database_cluster.blobscan_redis.host}"
}

output "redis_port" {
 value = "${digitalocean_database_cluster.blobscan_redis.port}"
}
