terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

data "aws_secretsmanager_secret" "api_key" {
  arn = var.datadog_api_key_arn
}

data "aws_secretsmanager_secret_version" "api_key" {
  secret_id = data.aws_secretsmanager_secret.api_key.id
}

data "aws_secretsmanager_secret" "app_key" {
  arn = var.datadog_app_key_arn
}

data "aws_secretsmanager_secret_version" "app_key" {
  secret_id = data.aws_secretsmanager_secret.app_key.id
}

provider "datadog" {
  api_key = data.aws_secretsmanager_secret_version.api_key.secret_string
  app_key = data.aws_secretsmanager_secret_version.app_key.secret_string
}
