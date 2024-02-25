# ECR構築時にイメージをpushする構成にしていないため初回実行時は必ずエラーになる
# ECRに最新イメージをpushしてから再度terraform applyを実行すること
resource "aws_lambda_function" "example_api" {
  function_name = "${local.sig}-lambda-function"
  description   = "managed by terraform"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.example.repository_url}:latest"
  architectures = ["x86_64"]
  role          = aws_iam_role.example_api.arn
  memory_size   = 128
  timeout       = 30

  environment {
    variables = {
      ENVIRONMENT : "staging"
    }
  }

  tags = (merge(local.default_tags,
    {
      "Name" = "${local.sig}-lambda-function",
    }
  ))
}

resource "aws_lambda_permission" "allow_alb" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_api.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.example_alb_tg.arn
}
