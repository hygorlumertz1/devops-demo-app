variable "aws_region" {
  description = "Região AWS onde os recursos serão provisionados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo nos recursos"
  type        = string
  default     = "devops-demo"
}

variable "environment" {
  description = "Ambiente de implantação (dev, staging, prod)"
  type        = string
  default     = "prod"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "O ambiente deve ser dev, staging ou prod."
  }
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos AWS"
  type        = map(string)
  default = {
    Project     = "DevOps Demo"
    ManagedBy   = "Terraform"
    Course      = "DevOps na Prática - PUCRS"
  }
}
