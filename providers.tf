terraform {
  required_version = "~> 1.8.1"

  required_providers {
    rancher2 = {
      source  = "opentofu/rancher2"
      version = "4.1.0"
    }
    local = {
      source  = "opentofu/local"
      version = "2.5.1"
    }
    http = {
      source  = "opentofu/http"
      version = "3.4.4"
    }
  }
}

provider "rancher2" {
  api_url   = var.rancher2_api_url
  token_key = var.rancher2_token_key
  insecure  = true
}