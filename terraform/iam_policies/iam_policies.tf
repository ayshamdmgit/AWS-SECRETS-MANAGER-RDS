data "aws_iam_policy_document" "lambda_invoke_policy" {
  statement {
    sid = "Invoke Lambda"

    actions = [
      "lambda:GetFunction",
      "lambda:InvokeAsync",
      "lambda:InvokeFunction"]

    resources = [
      "arn:aws:lambda:::*",
    ]
  }
resource "aws_iam_policy" "lambda_invoke_policy" {
  name   = "Lambda-invoke-policy"
  policy = "${data.aws_iam_policy_document.lambda_invoke_policy.json}"
}

data "aws_iam_policy_document" "secrets_admin_policy" {
  statement {
    sid = "Secrets Manager Admin"

    actions = ["secretsmanager:*"]

    resources = [*]
  }
resource "aws_iam_policy" "secrets_admin_policy" {
  name   = "secrets-admin-policy"
  policy = "${data.aws_iam_policy_document.secrets_admin_policy.json}"
}

data "aws_iam_policy_document" "vpc_policy" {
  statement {
    sid = "VPC ENI policies"

    actions = [
"ec2:DescribeNetworkInterfaces",
"ec2:CreateNetworkInterfaces",
"ec2:DeleteNetworkInterfaces"]

    resources = [*]
  }
resource "aws_iam_policy" "vpc_policy" {
  name   = "vpc-secret-mgr-policy"
  policy = "${data.aws_iam_policy_document.vpc_policy.json}"
}

data "aws_iam_policy_document" "secrets_mgr_read_policy" {
  statement {
    sid = "Secrets Manager Read Policy"

    actions = ["secretsmanager:getSecretValue"]

    resources = [*]
  }
resource "aws_iam_policy" "secrets_mgr_read_policy" {
  name   = "secret-mgr-read-policy"
  policy = "${data.aws_iam_policy_document.secrets_mgr_read_policy.json}"
}
