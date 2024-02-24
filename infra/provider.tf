terraform {
  required_version = "~> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # backend "s3" {
  #   bucket = "tf-remote-backend"
  #   key    = "./terraform.tfstate"
  #   region = "ap-northeast-1"
  # }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
