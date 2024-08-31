# Define the Azure ENV settings
variable "azure_env" {
  description = "Azure required details"
  type = object({
    az_client_id       = string
    az_client_secret   = string
    az_subscription_id = string
  })
}

# Define the kube-vip details
variable "kube_vip" {
  description = "kube-vip basic settings"
  type = object({
    int_name         = string
    kube_vip_address = string
    kube_vip_pool    = string
  })
}

# Specify the RKE2 cluster details
variable "rancher_env" {
  description = "RKE2 cluster required variables"
  type = object({
    cluster_annotations = map(string)
    cluster_labels      = map(string)
    rke2_version        = string
    cluster_id          = string
    network_policy      = bool
  })
}

# Define the RKE2 cluster node details
variable "node" {
  description = "Two RKE2 nodes to be configured"
  type = object({
    controller = object({
      name           = string
      agent_disk     = optional(number)
      image          = optional(string)
      location       = optional(string)
      open_port      = optional(list(string))
      resource_group = optional(string)
      storage_type   = optional(string)
      agent_type     = optional(string)
      quantity       = number
    })
    worker = object({
      name           = string
      agent_disk     = optional(number)
      image          = optional(string)
      location       = optional(string)
      open_port      = optional(list(string))
      resource_group = optional(string)
      storage_type   = optional(string)
      agent_type     = optional(string)
      quantity       = number
    })
  })
}

# Specify the Rancher API URL
variable "rancher2_api_url" {
  description = "Rancher API URL"
  type        = string
}

# Specify the Rancher TOKEN
variable "rancher2_token_key" {
  description = "Rancher API Token key"
  type        = string
}

# Specify an SSH public key to connect to the nodes
variable "rke2_ssh_public_key" {
  description = "RKE2 cluster SSH public key"
  type        = string
}

# Specify the RKE2 cluster CIDR
variable "rke_cluster_cidr" {
  description = "RKE2 cluster CIDR"
  type        = string
}

# Specify the RKE2 service CIDR
variable "rke_service_cidr" {
  description = "RKE2 service CIDR"
  type        = string
}
