## External DNS

resource "aws_iam_role" "external-dns" {
  name = "${var.env}-pod-external-dns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "external-dns"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["route53:*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

}

resource "aws_eks_pod_identity_association" "external-dns" {
  cluster_name    = var.env
  namespace       = "tools"
  service_account = "external-dns"
  role_arn        = aws_iam_role.external-dns.arn
}

## Prometheus EC2 Discovery

resource "aws_iam_role" "prometheus-server" {
  name = "${var.env}-pod-prometheus-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "external-dns"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceStatus"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

}

resource "aws_eks_pod_identity_association" "prometheus-server" {
  cluster_name    = var.env
  namespace       = "tools"
  service_account = "kube-prometheus-stack-prometheus"
  role_arn        = aws_iam_role.external-dns.arn
}




