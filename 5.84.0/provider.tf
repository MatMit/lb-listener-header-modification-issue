terraform {
    required_version = ">=1.7"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "5.84.0"
      }
    }

    backend "local" {
      path = "../terraform.tfstate"
    }
}