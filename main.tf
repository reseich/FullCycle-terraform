terraform {
  required_version = "1.0.11"
  required_providers {
    aws   = ">=3.66.0"
    local = ">=2.1.0"
  }
  backend "s3" {
    bucket = "reseich"
    key = "terraform.tfstate"
    region = "sa-east-1"
  }
}

provider "aws" {
  region = "sa-east-1"
}

module "new-vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}
module "eks" {
  source = "./modules/eks"
  cluster_name   = var.cluster_name
  desired_size   = var.desired_size
  max_size       = var.max_size
  min_size       = var.min_size
  prefix         = var.prefix
  retention_days = var.retention_days
  subnet_ids     = module.new-vpc.subnets_id
  vpc_id         = module.new-vpc.vpc_id
}