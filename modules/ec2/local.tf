locals {
  iam_policy = concat(["sts:GetCallerIdentity", "ssm:UpdateInstanceInformation"], var.iam_policy)
}
