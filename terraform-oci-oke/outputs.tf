output "AnudeepOKECluster" {
  value = {
    id                 = oci_containerengine_cluster.AnudeepOKECluster.id
    kubernetes_version = oci_containerengine_cluster.AnudeepOKECluster.kubernetes_version
    name               = oci_containerengine_cluster.AnudeepOKECluster.name
  }
}

output "AnudeepOKENodePool" {
  value = {
    id                 = oci_containerengine_node_pool.AnudeepOKENodePool.id
    kubernetes_version = oci_containerengine_node_pool.AnudeepOKENodePool.kubernetes_version
    name               = oci_containerengine_node_pool.AnudeepOKENodePool.name
    subnet_ids         = oci_containerengine_node_pool.AnudeepOKENodePool.subnet_ids
  }
}

output "Anudeep_Cluster_Kubernetes_Versions" {
  value = [data.oci_containerengine_cluster_option.AnudeepOKEClusterOption.kubernetes_versions]
}

output "Anudeep_Cluster_NodePool_Kubernetes_Version" {
  value = [data.oci_containerengine_node_pool_option.AnudeepOKEClusterNodePoolOption.kubernetes_versions]
}
