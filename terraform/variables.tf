variable "project_name" {
  type = string
}

variable "gcp_credentials_path" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_pub_key_path" {
  type = string
}

variable "env" {
  type = string
}

variable "network" {
  type = string
}

variable "do_token" {
  type = string
}

variable "do_region" {
  type = string
}

variable "database_size" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "domain" {
  type = string
}

// Vercel

variable "vercel_team_id" {
  type = string
}

variable "vercel_token" {
  type = string
}

// Vercel - project variables

variable "github_ref" {
  type = string
}

variable "chain_id" {
  type = string
}

variable "explorer_url" {
  type = string
}

variable "beacon_url" {
  type = string
}

variable "database_url" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "discord_webhook_url" {
  type = string
}

variable "bee_endpoint" {
  type = string
}

variable "bee_debug_endpoint" {
  type = string
}

variable "gcs_bucket" {
  type = string
}

variable "google_service_key" {
  type = string
}