terraform {
  cloud {
    organization = "1220-IAC"
    workspaces {
      name = "Landing_Bucket_Provision"
    }
  }
}

provider "aws" {
    region = var.region
    access_key  = var.aws_access_key
    secret_key  = var.aws_secret_key
}