variable "app_name" {
  description = "Application name"
  default     = "ssosync"
}

variable "google_group_match" {
  description = "Google Workspace group filter query parameter, example: 'name:Admin* email:aws-*', see: https://developers.google.com/admin-sdk/directory/v1/guides/search-groups"
  default     = "email:aws-*"
}

variable "google_credentials" {
  description = "Credentials to log into Google (content of credentials.json)"
  default     = <<EOT
{
  "type": "service_account",
  "project_id": "aws-login-319311",
  "private_key_id": "234e56rt789yuftdgchvjbkjjuyter",
  "private_key": "-----BEGIN PRIVATE KEY-----\nxxxxx=\n-----END PRIVATE KEY-----\n",
  "client_email": "aws-login@xhgchg1.iam.gserviceaccount.com",
  "client_id": "123456789",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://serviceaccount.com"
}
EOT
}

variable "google_admin_email" {
  description = "Google Admin email"
  default     = "praveenvvv@xxxxxxx.com"
}

variable "scim_endpoint_url" {
  description = "AWS SSO SCIM Endpoint Url"
  default     = "https://scim.ap-south-1.amazonaws.com/xxxxxxxxxx/scim/v2/"
}

variable "scim_access_token" {
  description = "AWS SSO SCIM AccessToken"
  default     = "c7xxxxxxxx8:xxxxxxxxx=="
}