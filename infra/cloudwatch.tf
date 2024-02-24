resource "aws_cloudwatch_log_group" "example_cloudwatch_log" {
  name              = "/aws/lambda/${aws_lambda_function.example_api.function_name}"
  kms_key_id        = ""
  retention_in_days = 1
  skip_destroy      = false

  tags = (merge(local.default_tags,
    {
      "Name" = "${local.sig}-aws-cloudwatch-log-group",
    }
  ))
}
