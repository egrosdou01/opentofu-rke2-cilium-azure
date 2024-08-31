# Download kube-vip RBAC manifest
data "http" "kube_vip_rbac" {
  url = "https://kube-vip.io/manifests/rbac.yaml"
}

# Download kube-vip specific version
data "http" "kube_vip_version" {
  method = "GET"
  url    = "https://api.github.com/repos/kube-vip/kube-vip/releases#v0.8.2"
}

# Download kube-vip-cloud-provider RBAC manisfest
data "http" "kube_vip_cloud_provider" {
  url = "https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml"
}

# Retrieve the system-id from Rancher
data "rancher2_namespace" "kube_system" {
  name       = "kube-system"
  project_id = data.rancher2_project.system.id
}

# Retrieve the cluster-id from Rancher
data "rancher2_project" "system" {
  name       = "System"
  cluster_id = rancher2_cluster_v2.rke2.cluster_v1_id
}
