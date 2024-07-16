output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "openid_arn" {
  value = aws_iam_openid_connect_provider.this[0].arn
}