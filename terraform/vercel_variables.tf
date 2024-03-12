resource "vercel_project_environment_variable" "chain_id" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "CHAIN_ID"
  value      = "${var.chain_id}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "explorer_url" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "NEXT_PUBLIC_EXPLORER_BASE_URL"
  value      = "${var.explorer_url}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "beacon_url" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "NEXT_PUBLIC_BEACON_BASE_URL"
  value      = "${var.beacon_url}"
  target     = ["production"]
}


resource "vercel_project_environment_variable" "network" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "NEXT_PUBLIC_NETWORK_NAME"
  value      = "${var.network}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "database_url" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "DATABASE_URL"
  value      = "${var.database_url}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "secret_key" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "SECRET_KEY"
  value      = "${var.secret_key}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "gcs_bucket" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "GOOGLE_STORAGE_BUCKET_NAME"
  value      = "${var.gcs_bucket}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "google_service_key" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "GOOGLE_SERVICE_KEY"
  value      = "${var.google_service_key}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "enable_gcs" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "GOOGLE_STORAGE_ENABLED"
  value      = "true"
  target     = ["production"]
}


resource "vercel_project_environment_variable" "enable_swarm" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "SWARM_STORAGE_ENABLED"
  value      = "false"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "enable_propagator" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "BLOB_PROPAGATOR_ENABLED"
  value      = "false"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "enable_postgres" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "POSTGRES_STORAGE_ENABLED"
  value      = "false"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "discord_webhook" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "FEEDBACK_WEBHOOK_URL"
  value      = "${var.discord_webhook_url}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "google_project_id" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "GOOGLE_STORAGE_PROJECT_ID"
  value      = "${var.project_name}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "enable_metrics" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "METRICS_ENABLED"
  value      = "true"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "bee_debug_endpoint" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "BEE_DEBUG_ENDPOINT"
  value      = "${var.bee_debug_endpoint}"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "bee_endpoint" {
  project_id = vercel_project.blobscan.id
  team_id    = "${var.vercel_team_id}"
  key        = "BEE_ENDPOINT"
  value      = "${var.bee_endpoint}"
  target     = ["production"]
}
