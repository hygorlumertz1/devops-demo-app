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

  # Para testes locais com LocalStack, descomente as linhas abaixo:
  # access_key                  = "test"
  # secret_key                  = "test"
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true
  # endpoints {
  #   s3          = "http://localhost:4566"
  #   cloudfront  = "http://localhost:4566"
  # }
}
