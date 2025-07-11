instances = {
  frontend = {
    instance_type = "t3.small"
  }
  mysql = {
    instance_type = "t3.small"
  }
  mongodb = {
    instance_type = "t3.small"
  }
  redis = {
    instance_type = "t3.small"
  }
  rabbitmq = {
    instance_type = "t3.small"
  }
  cart = {
    instance_type = "t3.small"
  }
  catalogue = {
    instance_type = "t3.small"
  }
  user = {
    instance_type = "t3.small"
  }
  shipping = {
    instance_type = "t3.small"
  }
  payment = {
    instance_type = "t3.small"
  }
}

env       = "prod"
ami       = "ami-0d4983d93b76c67c3"
zone_id   = "Z09055292Q5WKIF45FE2E"
zone_name = "rdevopsb85.online"

