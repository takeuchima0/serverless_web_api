resource "aws_s3_bucket" "alb_logs_bucket" {
  bucket = "${local.sig}-alb-access-logs"

  tags = (merge(local.default_tags,
    {
      "Name" = "${local.sig}-alb-access-logs",
    }
  ))
}
