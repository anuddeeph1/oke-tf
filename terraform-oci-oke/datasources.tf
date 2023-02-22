data "oci_containerengine_cluster_option" "AnudeepOKEClusterOption" {
  cluster_option_id = "all"
}

data "oci_containerengine_node_pool_option" "AnudeepOKEClusterNodePoolOption" {
  node_pool_option_id = "all"
}

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}