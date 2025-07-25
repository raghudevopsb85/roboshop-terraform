instances = {
  frontend = {
    instance_type = "t3.small"
    disk_size     = 30
  }
  mysql = {
    instance_type = "t3.small"
    disk_size     = 20
  }
  mongodb = {
    instance_type = "t3.small"
    disk_size     = 20
  }
  redis = {
    instance_type = "t3.small"
    disk_size     = 20
  }
  rabbitmq = {
    instance_type = "t3.small"
    disk_size     = 20
  }
  cart = {
    instance_type = "t3.small"
    disk_size     = 30
  }
  catalogue = {
    instance_type = "t3.small"
    disk_size     = 30
  }
  user = {
    instance_type = "t3.small"
    disk_size     = 30
  }
  shipping = {
    instance_type = "t3.small"
    disk_size     = 30
  }
  payment = {
    instance_type = "t3.small"
    disk_size     = 30
  }
}

env       = "dev"
ami       = "ami-0d4983d93b76c67c3"
zone_id   = "Z09055292Q5WKIF45FE2E"
zone_name = "rdevopsb85.online"