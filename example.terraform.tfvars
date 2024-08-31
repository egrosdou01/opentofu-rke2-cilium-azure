kube_vip = {
  int_name         = "eth0" # This is the defined Azure network interface
  kube_vip_address = "x.x.x.x"
  kube_vip_pool    = "x.x.x.x-x.x.x.x"
}

node = {
  controller = { name = "controller", quantity = 1, agent_disk = 30, image = "canonical:UbuntuServer:18.04-LTS:latest", location = "westus", open_port = ["80/tcp", "443/tcp", "6443/tcp", "9345/tcp"], resource_group = "rancher-rg", storage_type = "Standard_LRS", agent_type = "Standard_D2_v2" },
  worker     = { name = "worker", quantity = 1, agent_disk = 30, image = "canonical:UbuntuServer:18.04-LTS:latest", location = "westus", open_port = ["80/tcp", "443/tcp", "6443/tcp", "9345/tcp"], resource_group = "rancher-rg", storage_type = "Standard_LRS", agent_type = "Standard_D2_v2" }
}

rancher_env = {
  cluster_annotations = { "env" = "test" }
  cluster_labels      = { "env" = "test" }
  rke2_version        = "v1.28.11+rke2r1"
  cluster_id          = "test01"
  network_policy      = "false"
}

rke_cluster_cidr = "10.42.0.0/16"
rke_service_cidr = "10.43.0.0/16"