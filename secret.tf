resource "aws_secretsmanager_secret" "google_credentials" {
  name = "SSOSyncGoogleCredentials"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "google_credentials_value" {
  secret_id     = aws_secretsmanager_secret.google_credentials.id
  secret_string = var.google_credentials
}


resource "aws_secretsmanager_secret" "google_admin_email" {
  name = "SSOSyncGoogleAdminEmail"
  recovery_window_in_days = 0
}


resource "aws_secretsmanager_secret_version" "google_admin_email_value" {
  secret_id     = aws_secretsmanager_secret.google_admin_email.id
  secret_string = var.google_admin_email
}


resource "aws_secretsmanager_secret" "scim_endpoint_url" {
  name = "SSOSyncSCIMEndpointUrl"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "scim_endpoint_url_value" {
  secret_id     = aws_secretsmanager_secret.scim_endpoint_url.id
  secret_string = var.scim_endpoint_url
}


resource "aws_secretsmanager_secret" "scim_access_token" {
  name = "SSOSyncSCIMAccessToken"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "scim_access_token_value" {
  secret_id     = aws_secretsmanager_secret.scim_access_token.id
  secret_string = var.scim_access_token
}
