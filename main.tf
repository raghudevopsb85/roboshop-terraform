module "vpc" {
  source = "./modules/vpc"

  for_each       = var.vpc
  env            = var.env
  subnets        = each.value["subnets"]
  vpc_cidr_block = each.value["vpc_cidr_block"]
  vpc_peers      = each.value["vpc_peers"]
}

# module "ec2" {
#   for_each      = var.databases
#   source        = "./modules/ec2"
#   ami           = var.ami
#   env           = var.env
#   instance_type = each.value["instance_type"]
#   disk_size     = each.value["disk_size"]
#   name          = each.key
#   zone_id       = var.zone_id
#   token         = var.token
# }


# module "eks" {
#   for_each    = var.eks
#   source      = "./modules/eks"
#   env         = var.env
#   eks_version = each.value["eks_version"]
#   subnet_ids  = each.value["subnet_ids"]
#   node_groups = each.value["node_groups"]
#   access      = each.value["access"]
#   addons      = each.value["addons"]
#   vault_token = var.token
# }



