provider "aws" {
  region = "ap-southeast-1"
}


terraform {
  backend "s3" {
    bucket = "tungnns-terraform-state"
    key    = "dev/eks/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "tungnns-terraform-statelock"
    assume_role = {
      role_arn = "arn:aws:iam::767397974892:role/terraform"
    }
  }
}


module "vpc" {
  source = "../../modules/vpc"

  env                  = "dev"
  azs                  = ["ap-southeast-1a", "ap-southeast-1b"]
  vpc_cidr_block       = "10.0.0.0/16"
  private_subnets_cidr = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets_cidr  = ["10.0.64.0/19", "10.0.96.0/19"]

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"         = 1
    "kubernetes.io/cluster/dev-demo" = "owned"
  }
}

module "eks" {
  source = "../../modules/eks"

  env          = "dev"
  cluster_name = "eks-cluster"
  eks_version  = "1.29"
  enable_irsa  = true
  subnet_ids   = module.vpc.private_subnet_ids
  node_groups = {
    general = {
      capacity_type  = "ON_DEMAND"
      instance_types = ["t2.medium"]
      scaling_config = {
        desired_size = 1
        max_size     = 2
        min_size     = 1
      }
    }
  }
}
    