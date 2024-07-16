variable "env" {
  description = "Environment"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "eks_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ID"
  type        = list(string)
}

variable "node_groups" {
  description = "Node groups name"
  type        = map(any)
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
}

variable "node_iam_policies" {
  description = "IAM policies for the node group"
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

