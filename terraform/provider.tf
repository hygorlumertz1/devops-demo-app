terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # Credenciais mock para validação local (terraform plan/validate sem conta AWS).
  # Para deploy real: exporte AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY, remova estas linhas.
  # Para usar LocalStack: troque os endpoints pelo endereço do LocalStack (http://localhost:4566).
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}
