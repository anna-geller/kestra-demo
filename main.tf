terraform {
  required_version = ">= 1.5.2"
  required_providers {
    kestra = {
      source  = "kestra-io/kestra"
      version = "~>0.7.0"
    }
  }
}

provider "kestra" {
  url      = var.hostname
  username = var.username
  password = var.password
}

resource "kestra_flow" "flows" {
  for_each             = fileset(path.module, "kestra/flows/*.yml")
  flow_id              = yamldecode(templatefile(each.value, {}))["id"]
  namespace            = yamldecode(templatefile(each.value, {}))["namespace"]
  content              = templatefile(each.value, {})
  keep_original_source = true
}

resource "kestra_flow" "subflows" {
  for_each             = fileset(path.module, "kestra/subflows/*.yml")
  flow_id              = yamldecode(templatefile(each.value, {}))["id"]
  namespace            = yamldecode(templatefile(each.value, {}))["namespace"]
  content              = templatefile(each.value, {})
  keep_original_source = true
}

resource "kestra_flow" "main" {
  for_each             = fileset(path.module, "kestra/main/*.yml")
  flow_id              = yamldecode(templatefile(each.value, {}))["id"]
  namespace            = yamldecode(templatefile(each.value, {}))["namespace"]
  content              = templatefile(each.value, {})
  keep_original_source = true
}

resource "kestra_namespace_secret" "github_pat" {
  namespace    = "prod"
  secret_key   = "GITHUB_PAT"
  secret_value = var.github_access_token
}