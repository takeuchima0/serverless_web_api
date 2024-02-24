resource "aws_iam_role" "example_api" {
  name               = "${local.sig}-iam_role"
  assume_role_policy = file("./common/assume_role/lambda.json")
}

resource "aws_iam_role_policy_attachment" "example_api" {
  role       = aws_iam_role.example_api.name
  policy_arn = aws_iam_policy.example_api.arn
}

resource "aws_iam_policy" "example_api" {
  name   = "${local.sig}-iam_policy"
  policy = data.aws_iam_policy_document.example_api.json
}

data "aws_iam_policy_document" "example_api" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
    "arn:aws:logs:*:*:*"]
  }
}
