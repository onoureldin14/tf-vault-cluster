data "aws_arn" "peer" {
  count = var.vault_cluster_gcp == false ? 1 : 0
  arn   = aws_vpc.peer[0].arn
}

data "google_iam_policy" "noauth" {
  count = var.vault_cluster_gcp == true ? 1 : 0
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
