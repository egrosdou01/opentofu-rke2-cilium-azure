# Output the Rancher cluster name
output "rke2_cluster_name" {
  value = rancher2_cluster_v2.rke2.name
}

# Output the Rancher cluster ID
output "rancher_cluster_id" {
  value = data.rancher2_project.system.cluster_id
}
