terraform {
    backend "s3" {
	bucket = "statefiles-collection-eks"
	key = "terraform/statefile_qs_EC2_simulations.tfstate"
	region = "eu-central-1"
    }
}

# include providers
provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
  }
}

data "aws_availability_zones" "available" {}
