resource "digitalocean_database_cluster" "blobscan_redis" {
  name       = "blobscan-redis-prod"
  engine     = "redis"
  version    = "7"
  size       = "${var.redis_size}"
  region     = "${var.do_region}"
  node_count = "${var.redis_count}"
  tags       = ["blobscan", "redis"]
}

output "redis_host" {
 value = "${digitalocean_database_cluster.blobscan_redis.host}"
}

output "redis_port" {
 value = "${digitalocean_database_cluster.blobscan_redis.port}"
}
