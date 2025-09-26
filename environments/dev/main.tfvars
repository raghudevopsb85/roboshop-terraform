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
#   mysql = {
#     instance_type = "t3.small"
#     disk_size     = 20
#     subnet_ref    = "db-az1"
#   }
#   mongodb = {
#     instance_type = "t3.small"
#     disk_size     = 20
#     subnet_ref    = "db-az1"
#   }
#   redis = {
#     instance_type = "t3.small"
#     disk_size     = 20
#     subnet_ref    = "db-az2"
#   }
#   rabbitmq = {
#     instance_type = "t3.small"
#     disk_size     = 20
#     subnet_ref    = "db-az2"
#   }
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
      spot1 = {
        min_nodes      = 1
        max_nodes      = 10
        instance_types = ["t3.xlarge"]
        capacity_type  = "SPOT"
      }
      #       one = {
      #         min_nodes       = 2
      #         max_nodes       = 10
      #         instance_types  = ["t3.medium"]
      #         capacity_type   = "ON_DEMAND"
      #       }
    }
    access = {
      workstation = {
        principal_arn = "arn:aws:iam::739561048503:role/workstation-role"
        access_scope  = "cluster"
        policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      }
      github-runner = {
        principal_arn = "arn:aws:iam::739561048503:role/github-runner-ec2-role"
        access_scope  = "cluster"
        policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      }
    }
    addons = {
      vpc-cni = {
        config = {
          "enableNetworkPolicy" : "true",
          "nodeAgent" : {
            "enablePolicyEventLogs" : "true"
          }
        }
      }

      eks-pod-identity-agent = {
        config = {}
      }

    }
  }
}


vpc = {
  main = {
    vpc_cidr_block = "10.10.0.0/16"
    subnets = {
      app-az1 = {
        cidr_block        = "10.10.10.0/24"
        availability_zone = "us-east-1a"
        ngw               = true
      }
      app-az2 = {
        cidr_block        = "10.10.11.0/24"
        availability_zone = "us-east-1b"
        ngw               = true
      }
      db-az1 = {
        cidr_block        = "10.10.12.0/24"
        availability_zone = "us-east-1a"
        ngw               = true
      }
      db-az2 = {
        cidr_block        = "10.10.13.0/24"
        availability_zone = "us-east-1b"
        ngw               = true
      }
      gateway = {
        cidr_block        = "10.10.0.0/24"
        availability_zone = "us-east-1a"
        igw               = true
      }
    }
    vpc_peers = {
      "vpc-06ac3dd6a7a23a33a" = {
        name        = "default"
        vpc_id      = "vpc-06ac3dd6a7a23a33a"
        vpc_cidr    = "172.31.0.0/16"
        route_table = "rtb-00e8a453486ad1e90"
      }
    }
  }
}

bastion_nodes = ["172.31.20.239/32"]
