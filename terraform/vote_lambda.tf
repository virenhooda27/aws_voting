data "archive_file" "vote" {
  type        = "zip"
  source_file = "../vote.py"
  output_path = "/tmp/vote.zip"
}

resource "aws_iam_role" "vote_lambda_exec" {
  name = "vote-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect    = "Allow",
      Sid       = ""
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_dynamo" {
  name       = "lambda-dynamo-policy"
  roles      = [aws_iam_role.vote_lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_lambda_function" "vote" {
  function_name = "vote-function"
  role          = aws_iam_role.vote_lambda_exec.arn
  handler       = "vote.lambda_handler"
  runtime       = "python3.9"
  filename      = data.archive_file.vote.output_path
  source_code_hash = data.archive_file.vote.output_base64sha256
}

resource "aws_apigatewayv2_api" "vote_api" {
  name          = "vote-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "vote_integration" {
  api_id           = aws_apigatewayv2_api.vote_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.vote.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "vote_route" {
  api_id    = aws_apigatewayv2_api.vote_api.id
  route_key = "POST /vote"
  target    = "integrations/${aws_apigatewayv2_integration.vote_integration.id}"
}

resource "aws_apigatewayv2_stage" "vote_stage" {
  api_id      = aws_apigatewayv2_api.vote_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vote.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.vote_api.execution_arn}/*/*"
}