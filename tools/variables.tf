variable "zone_id" {
  default = "Z09055292Q5WKIF45FE2E"
}

variable "ami" {
  default = "ami-09c813fb71547fc4f"
}

variable "tools" {
  default = {
    vault = {
      instance_type = "t3.small"
    }
    github-runner = {
      instance_type = "t3.small"
      iam_policy    = ["*"]
      disk_size     = 50
    }
  }
}

variable "token" {}

variable "ecr" {
  default = {
    frontend  = "IMMUTABLE"
    cart      = "IMMUTABLE"
    catalogue = "IMMUTABLE"
    user      = "IMMUTABLE"
    shipping  = "IMMUTABLE"
    payment   = "IMMUTABLE"
    runner    = "MUTABLE"
  }
}

