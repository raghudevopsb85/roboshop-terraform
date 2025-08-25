resource "aws_eks_cluster" "main" {
  name     = var.env
  role_arn = aws_iam_role.cluster.arn
  version  = var.eks_version
  vpc_config {
    subnet_ids = var.subnet_ids
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}

resource "aws_eks_node_group" "main" {
  for_each        = var.node_groups
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = each.value["min_nodes"]
    min_size     = each.value["min_nodes"]
    max_size     = each.value["max_nodes"]
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_eks_addon" "main" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "vpc-cni"
  configuration_values = jsonencode({
    "enableNetworkPolicy" : "true",
    "nodeAgent" : {
      "enablePolicyEventLogs" : "true"
    }
  })
}

