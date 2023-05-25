resource "aws_ssm_parameter" "zendesk_token" {
  name        = "/${var.env}-ztm/zendesk_token"
  type        = "SecureString"
  value       = var.zendesk_token
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.env}-ztm/db_password"
  type        = "SecureString"
  value       = random_password.db_password.result
}
