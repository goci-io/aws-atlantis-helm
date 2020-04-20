locals {
  release_name = length(var.attributes) > 0 ? format("%s-%s", var.name, join("-", var.attributes)) : var.name
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "atlantis" {
  name          = local.release_name
  namespace     = var.k8s_namespace
  version       = var.helm_release_version
  repository    = data.helm_repository.stable.metadata[0].name
  chart         = "atlantis"
  recreate_pods = true
  wait          = true

  values = [
    file("${path.module}/defaults.yaml"),
    file("${path.module}/values.yaml"),
  ]

  set {
    name  = "orgWhitelist"
    value = var.organization
  }

  set {
    name  = "atlantisUrl"
    value = "https://${var.name}.${var.cluster_fqdn}"
  }

  set {
    name  = "repoConfig"
    value = local.repos_config
  }

  set {
    name  = format("%s.%s", var.vc_type, local.host_attribute[var.vc_type])
    value = var.vc_host
  }

  dynamic "set_sensitive" {
    for_each = ["user", "token", "secret"]

    content {
      name  = format("%s.%s", var.vc_type, set_sensitive.value)
      value = local.sensitives[set_sensitive.value]
    }
  }
  
  dynamic "set" {
    for_each = var.pod_annotations

    content {
      name  = format("podTemplate.annotations.%s", replace(set.key, "\\.", "\\\\\\."))
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.environment_variables

    content {
      name  = format("environment.%s", upper(set.key))
      value = set.value
    }
  }
}
