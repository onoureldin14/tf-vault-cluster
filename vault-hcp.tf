resource "hcp_hvn" "hcp_vault_hvn" {
  count          = var.vault_cluster_gcp == false ? 1 : 0
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}

resource "hcp_vault_cluster" "hcp_vault" {
  count           = var.vault_cluster_gcp == false ? 1 : 0
  hvn_id          = hcp_hvn.hcp_vault_hvn[0].hvn_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = true
}

resource "hcp_vault_cluster_admin_token" "admin_token" {
  count      = var.vault_cluster_gcp == false ? 1 : 0
  cluster_id = var.cluster_id
  depends_on = [hcp_vault_cluster.hcp_vault]
}

resource "aws_vpc" "peer" {
  count      = var.vault_cluster_gcp == false ? 1 : 0
  cidr_block = "172.31.0.0/16"
}

resource "hcp_aws_network_peering" "peer" {
  count           = var.vault_cluster_gcp == false ? 1 : 0
  hvn_id          = hcp_hvn.hcp_vault_hvn[0].hvn_id
  peering_id      = var.peering_id
  peer_vpc_id     = aws_vpc.peer[0].id
  peer_account_id = aws_vpc.peer[0].owner_id
  peer_vpc_region = data.aws_arn.peer[0].region
}

resource "hcp_hvn_route" "peer_route" {
  count            = var.vault_cluster_gcp == false ? 1 : 0
  hvn_link         = hcp_hvn.hcp_vault_hvn[0].self_link
  hvn_route_id     = var.route_id
  destination_cidr = aws_vpc.peer[0].cidr_block
  target_link      = hcp_aws_network_peering.peer[0].self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  count                     = var.vault_cluster_gcp == false ? 1 : 0
  vpc_peering_connection_id = hcp_aws_network_peering.peer[0].provider_peering_id
  auto_accept               = true
}
