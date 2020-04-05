resource "aws_lambda_function" "secret_access_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = [aws_iam_policy.secrets_mgr_read_policy.arn,
                   aws_iam_policy.vpc_policy.arn]
  handler       = "lambda_handler.rds_pwd_rotator"
  filename      = data.archive_file.secret_rotator_zip.output_path
  source_code_hash =   data.archive_file.secret_rotator_zip.output_base64sha256
  runtime       = "python3.7"
  vpc_config {
      security_group_ids = ["Sgs_1", "Sgs_2", "Sgs_3"],
      subnet_ids         = ["Subnet_id_1", "Subnet_id_2"]
}
