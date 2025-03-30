terraform {
  backend "s3" {
    encrypt      = true
    use_lockfile = true
    key          = "example-terraform-faas-aws-lambda.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
