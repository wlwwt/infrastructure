terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.25.0"
    }
  }
  backend "remote" {
    organization = "nexton"

    workspaces {
      name = "nexton-infrastructure"
    }
  }
}

provider "aws" {}