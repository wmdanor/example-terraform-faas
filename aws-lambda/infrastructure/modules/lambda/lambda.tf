resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn

  runtime       = "provided.al2023"
  handler       = "bootstrap"
  architectures = ["arm64"]
  memory_size   = 128


  filename = "${path.module}/../../dummy.zip"
  lifecycle {
    ignore_changes = [
      filename
    ]
  }
}
