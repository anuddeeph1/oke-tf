resource "oci_core_vcn" "AnudeepVCN" {
  cidr_block     = var.VCN-CIDR
  compartment_id = oci_identity_compartment.AnudeepCompartment.id
  display_name   = "AnudeepVCN"
}

resource "oci_core_internet_gateway" "AnudeepInternetGateway" {
  compartment_id = oci_identity_compartment.AnudeepCompartment.id
  display_name   = "AnudeepInternetGateway"
  vcn_id         = oci_core_vcn.AnudeepVCN.id
}

resource "oci_core_route_table" "AnudeepRouteTableViaIGW" {
  compartment_id = oci_identity_compartment.AnudeepCompartment.id
  vcn_id         = oci_core_vcn.AnudeepVCN.id
  display_name   = "AnudeepRouteTableViaIGW"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.AnudeepInternetGateway.id
  }
}

resource "oci_core_security_list" "AnudeepOKESecurityList" {
  compartment_id = oci_identity_compartment.AnudeepCompartment.id
  display_name   = "AnudeepOKESecurityList"
  vcn_id         = oci_core_vcn.AnudeepVCN.id

  egress_security_rules {
    protocol    = "All"
    destination = "0.0.0.0/0"
  }

  /* This entry is necesary for DNS resolving (open UDP traffic). */
  ingress_security_rules {
    protocol = "17"
    source   = var.VCN-CIDR
  }
}

resource "oci_core_subnet" "AnudeepClusterSubnet" {
  cidr_block     = var.AnudeepClusterSubnet-CIDR
  compartment_id = oci_identity_compartment.AnudeepCompartment.id
  vcn_id         = oci_core_vcn.AnudeepVCN.id
  display_name   = "AnudeepClusterSubnet"

  security_list_ids = [oci_core_vcn.AnudeepVCN.default_security_list_id, oci_core_security_list.AnudeepOKESecurityList.id]
  route_table_id    = oci_core_route_table.AnudeepRouteTableViaIGW.id
}

resource "oci_core_subnet" "AnudeepNodePoolSubnet" {
  cidr_block        = var.AnudeepNodePoolSubnet-CIDR
  compartment_id    = oci_identity_compartment.AnudeepCompartment.id
  vcn_id            = oci_core_vcn.AnudeepVCN.id
  display_name      = "AnudeepNodePoolSubnet"
  security_list_ids = [oci_core_vcn.AnudeepVCN.default_security_list_id, oci_core_security_list.AnudeepOKESecurityList.id]
  route_table_id    = oci_core_route_table.AnudeepRouteTableViaIGW.id
}

