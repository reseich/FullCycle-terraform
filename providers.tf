terraform {
  required_version = "1.0.11"
  required_providers {
    aws   = ">=3.66.0"
    local = ">=2.1.0"
  }
}
provider "aws" {
  region = "sa-east-1"
}