locals {
  app_id = lower(var.app_name)
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../ssosync/main"
  output_path = "ssosync.zip"
}