locals {
  project = "serverless-web-api"
  env     = "dev"
  sig     = "${local.env}-${local.project}"

  default_tags = {
    project    = "${local.project}"
    env        = "${local.env}"
    managed-by = "terraform"
  }
}
