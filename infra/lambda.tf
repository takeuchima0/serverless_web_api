resource "aws_lambda_function" "example_api" {
  function_name = "${local.sig}-lambda-function"
  description   = "managed by terraform"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.example.repository_url}:latest"
  architectures = ["x86_64"]
  role          = aws_iam_role.example_api.arn

  memory_size = 128
  timeout     = 5

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
