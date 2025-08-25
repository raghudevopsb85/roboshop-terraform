# instances = {
#   frontend = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
#   mysql = {
#     instance_type = "t3.small"
#     disk_size     = 20
#   }
#   mongodb = {
#     instance_type = "t3.small"
#     disk_size     = 20
#   }
#   redis = {
#     instance_type = "t3.small"
#     disk_size     = 20
#   }
#   rabbitmq = {
#     instance_type = "t3.small"
#     disk_size     = 20
#   }
#   cart = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
#   catalogue = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
#   user = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
#   shipping = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
#   payment = {
#     instance_type = "t3.small"
#     disk_size     = 30
#   }
# }


databases = {
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
}


env       = "dev"
ami       = "ami-0d4983d93b76c67c3"
zone_id   = "Z09055292Q5WKIF45FE2E"
zone_name = "rdevopsb85.online"

eks = {
  main = {
    eks_version = 1.33
    subnet_ids  = ["subnet-05f2d527e96f275c9", "subnet-0506db159acceacf5"]
    node_groups = {
      one = {
        min_nodes = 1
        max_nodes = 10
      }
    }
    access = {
      workstation = {
        principal_arn = "arn:aws:iam::739561048503:role/workstation-role"
        access_scope  = "cluster"
        policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
      }
    }
  }
}
