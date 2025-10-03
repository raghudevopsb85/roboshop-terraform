data "vault_generic_secret" "ses" {
  path = "roboshop-infra/ses"
}

data "aws_subnets" "lb-az" {
  filter {
    name   = "tag:Name"
    values = ["lb-az1", "lb-az2"]
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.env]
  }
}

data "aws_subnets" "public-subnets" {
  filter {
    name   = "tag:Name"
    values = ["public-az1", "public-az2"]
  }
}

