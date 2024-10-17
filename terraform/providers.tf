terraform {
  cloud {
    organization = "<Your Terraform Organization>"
    workspaces {
      name = "<Terraform Enterprise Workspace>"
    }
  }
}
provider "aws" {
    region = var.region
    access_key  = var.aws_access_key
    secret_key  = var.aws_secret_key
}
