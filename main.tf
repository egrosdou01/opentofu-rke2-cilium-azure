# Create the Azure Cloud Credentials in Rancher
resource "rancher2_cloud_credential" "azure_creds" {
  name = "Azure Credentials"
  azure_credential_config {
    client_id       = var.azure_env.az_client_id
    client_secret   = var.azure_env.az_client_secret
    subscription_id = var.azure_env.az_subscription_id
  }
}

# Create the different nodes for RKE2 (controller and worker)
resource "rancher2_machine_config_v2" "nodes" {
  for_each      = var.node
  generate_name = each.value.name

  azure_config {
    disk_size            = each.value.agent_disk
    image                = each.value.image
    location             = each.value.location
    managed_disks        = true
    open_port            = each.value.open_port
    private_address_only = false
    resource_group       = each.value.resource_group
    storage_type         = each.value.storage_type
    size                 = each.value.agent_type
  }
}

# RKE2 configuration
resource "rancher2_cluster_v2" "rke2" {
  annotations           = var.rancher_env.cluster_annotations
  kubernetes_version    = var.rancher_env.rke2_version
  labels                = var.rancher_env.cluster_labels
  enable_network_policy = var.rancher_env.network_policy # Option to enable or disable Project Network Isolation.
  name                  = var.rancher_env.cluster_id

  rke_config {
    additional_manifest = templatefile("${path.module}/files/kube-vip-daemonset.tfmpl",
      {
        int_name                = var.kube_vip.int_name
        kube_vip_rbac           = data.http.kube_vip_rbac.response_body
        kube_vip_version        = jsondecode(data.http.kube_vip_version.response_body)[0]["tag_name"]
        kube_vip_address        = var.kube_vip.kube_vip_address
        kube_vip_pool           = var.kube_vip.kube_vip_pool
        kube_vip_cloud_provider = data.http.kube_vip_cloud_provider.response_body
    })

    chart_values = <<-EOF
      rke2-cilium:
        k8sServiceHost: 127.0.0.1
        k8sServicePort: 6443
        kubeProxyReplacement: true
      EOF

    machine_global_config = <<EOF
      cni: "cilium"
      cluster-cidr: ${var.rke_cluster_cidr}
      service-cidr: ${var.rke_service_cidr}
      disable-kube-proxy: true
      EOF

    dynamic "machine_pools" {
      for_each = var.node
      content {
        cloud_credential_secret_name = rancher2_cloud_credential.azure_creds.id
        control_plane_role           = machine_pools.key == "controller" ? true : false
        etcd_role                    = machine_pools.key == "controller" ? true : false
        name                         = machine_pools.value.name
        quantity                     = machine_pools.value.quantity
        worker_role                  = machine_pools.key != "controller" ? true : false

        machine_config {
          kind = rancher2_machine_config_v2.nodes[machine_pools.key].kind
          name = rancher2_machine_config_v2.nodes[machine_pools.key].name
        }
      }
    }

    machine_selector_config {
      config = null
    }

  }
}
