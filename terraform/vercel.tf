resource "vercel_project" "blobscan" {
  name      = "blobscan-${var.network}"
  team_id   = "${var.vercel_team_id}"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "blobscan/blobscan"
  }
  root_directory = "apps/web"
}

resource "vercel_project_domain" "blobscan" {
  project_id = vercel_project.blobscan.id
  team_id   = "${var.vercel_team_id}"
  domain     = "${var.domain}"
}
