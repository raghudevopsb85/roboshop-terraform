provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-b85"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "vault" {
  address        = "http://vault-internal.rdevopsb85.online:8200"
  token = var.token
}

