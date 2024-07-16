provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "tungnns-terraform-state"
    key    = "dev/vpc/terraform.tfstate"
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