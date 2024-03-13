resource "vercel_project" "blobscan" {
  name      = var.env == "staging" ? "blobscan-staging" : "blobscan-${var.network}"
  team_id   = "${var.vercel_team_id}"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "blobscan/blobscan"
  }
  root_directory = "apps/web"
  ignore_command = "if [ \"$VERCEL_ENV\" == \"production\" ]; then exit 1; else exit 0; fi"
}

resource "vercel_project_domain" "blobscan" {
  project_id = vercel_project.blobscan.id
  team_id   = "${var.vercel_team_id}"
  domain     = "${var.domain}"
}
