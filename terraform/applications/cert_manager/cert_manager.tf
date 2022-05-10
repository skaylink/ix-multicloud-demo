# Cert-Manager
# See https://cert-manager.io/
# See https://cert-manager.io/docs/tutorials/acme/ingress/

# Namespace
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

# Helm Release
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  version    = "1.8.0"
  timeout    = 600

  set {
    name  = "installCRDs"
    value = "true"
  }

  # https://github.com/jetstack/cert-manager/issues/3338
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

# Let's Encrypt ACME ClusterIssuer
resource "kubectl_manifest" "cert_manager_cluster_issuer" {
  depends_on = [helm_release.cert_manager]
  yaml_body = yamlencode({
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-production"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.cert_admin_email
        # required to not-break grpc clients
        preferredChain = "ISRG Root X1"
        privateKeySecretRef = {
          name = "letsencrypt-production"
        }

        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  })
}

# Let's Encrypt ACME ClusterIssuer
resource "kubectl_manifest" "cert_manager_staging_issuer" {
  depends_on = [helm_release.cert_manager]
  yaml_body = yamlencode({
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-staging"
    }
    spec = {
      acme = {
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
        email  = var.cert_admin_email
        # required to not-break grpc clients
        preferredChain = "ISRG Root X1"
        privateKeySecretRef = {
          name = "letsencrypt-staging"
        }

        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  })
}
