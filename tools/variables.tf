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
  }
}

variable "token" {}


