resource "aws_lambda_function" "lambda_func" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.app_id
  handler          = "main"
  source_code_hash = base64sha256(data.archive_file.lambda_zip.output_path)
  runtime          = "go1.x"
  role             = aws_iam_role.lambda_exec.arn
  timeout          = 300
  environment {
    variables = {
      SSOSYNC_LOG_LEVEL          = "warn"
      SSOSYNC_LOG_FORMAT         = "json"
      SSOSYNC_GOOGLE_CREDENTIALS = aws_secretsmanager_secret.google_credentials.arn
      SSOSYNC_GOOGLE_ADMIN       = aws_secretsmanager_secret.google_admin_email.arn
      SSOSYNC_SCIM_ENDPOINT      = aws_secretsmanager_secret.scim_endpoint_url.arn
      SSOSYNC_SCIM_ACCESS_TOKEN  = aws_secretsmanager_secret.scim_access_token.arn
      SSOSYNC_GROUP_MATCH = var.google_group_match
      SSOSYNC_SYNC_METHOD = "groups"
    }
  }
}
# Assume role setup
resource "aws_iam_role" "lambda_exec" {
  name_prefix         = local.app_id
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "secretsmanager:Get*",
          "Effect" : "Allow",
          "Resource" : [
            "${aws_secretsmanager_secret.google_credentials.arn}",
            "${aws_secretsmanager_secret.google_admin_email.arn}",
            "${aws_secretsmanager_secret.scim_endpoint_url.arn}",
            "${aws_secretsmanager_secret.scim_access_token.arn}"
          ]
        }
      ]
  })
}

resource "aws_iam_policy_attachment" "role_attach" {
  name       = "policy-${local.app_id}"
  roles      = [aws_iam_role.lambda_exec.id]
  policy_arn = aws_iam_policy.policy.arn
}