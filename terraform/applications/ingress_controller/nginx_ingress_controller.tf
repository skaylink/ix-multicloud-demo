#################################################################################################
#
# NGINX Ingress Controller
#
# See https://kubernetes.github.io/ingress-nginx/
# See https://cloud.google.com/community/tutorials/nginx-ingress-gke
#
#################################################################################################

# Namespace - but it's not namespace restricted!
resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

# Helm Release
# See https://kubernetes.github.io/ingress-nginx/deploy/#using-helm
# See https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  timeout    = 600

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.assigned_ip_address
  }

  set {
    # makes sure every node has its ingress for efficient loadbalancing
    name  = "controller.kind"
    value = "DaemonSet"
  }
}

data "kubernetes_service" "ingress_controller" {
  depends_on = [
    helm_release.ingress_nginx
  ]

  metadata {
    name      = "ingress-nginx-controller"
    namespace = kubernetes_namespace.nginx.metadata[0].name
  }
}

output "ip_address" {
  value = data.kubernetes_service.ingress_controller.status[0].load_balancer[0].ingress[0].ip
}
