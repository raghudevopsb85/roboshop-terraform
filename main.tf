# module "ec2" {
#   for_each      = var.instances
#   source        = "./modules/ec2"
#   ami           = var.ami
#   env           = var.env
#   instance_type = each.value["instance_type"]
#   disk_size     = each.value["disk_size"]
#   name          = each.key
#   zone_id       = var.zone_id
#   token         = var.token
# }
#

module "eks" {
  source = "./modules/eks"
}