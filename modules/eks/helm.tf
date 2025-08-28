resource "null_resource" "kubeconfig" {

  depends_on = [aws_eks_node_group.main]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.env}"
  }

}

resource "helm_release" "nginx_ingress" {
  depends_on       = [null_resource.kubeconfig]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "tools"
  create_namespace = true
  values           = [file("${path.module}/helm-values/ingress.yml")]

}

resource "helm_release" "external-dns" {
  depends_on       = [null_resource.kubeconfig]
  name             = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns"
  chart            = "external-dns"
  namespace        = "tools"
  create_namespace = true
}

resource "helm_release" "argocd" {
  depends_on       = [null_resource.kubeconfig, helm_release.nginx_ingress]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd"
  namespace        = "tools"
  create_namespace = true
}




