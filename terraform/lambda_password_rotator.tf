data "archive_file" "secret_rotator_zip" {
  type        = "zip"
  source_file = "${path.module}/init.tpl"
  output_path = "${path.module}/files/init.zip"
}
resource "aws_lambda_function" "secret_rotator_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = [aws_iam_policy.lambda_invoke_policy.arn,
                   aws_iam_policy.secrets_admin_policy.arn,
                   aws_iam_policy.vpc_policy.arn]
  handler       = "lambda_handler.rds_pwd_rotator"
  filename      = data.archive_file.secret_rotator_zip.output_path
  source_code_hash =   data.archive_file.secret_rotator_zip.output_base64sha256
  runtime       = "python3.7"
  vpc_config {
      security_group_ids = ["Sgs_1", "Sgs_2"....],
      subnet_ids         = ["Subnet_id_1", "Subnet_id_2"]
}

resource "aws_lambda_permission" "allow_secret_manager_call_Lambda" {
    function_name = "${aws_lambda_function.secret_rotator_lambda.function_name}"
    statement_id = "AllowExecutionSecretManager"
    action = "lambda:InvokeFunction"
    principal = "secretsmanager.amazonaws.com"
}

resource "aws_secretsmanager_secret" "secret" {
  description         = "Secret Manager for RDS"
  name                = "secret-mgr-rds"
  rotation_lambda_arn = aws_lambda_function.secret_rotator_lambda.function_name
  rotation_rules {
    automatically_after_days = 7
  }
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = "${aws_secretsmanager_secret.secret.id}"
  secret_string = <<EOF
{
  "password": "initial_password"
 }
EOF
}
