terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.60.0"
    }
  }

  backend "s3" {}


  required_version = ">= 1.14.0"
}

provider "aws" {
  region = "ap-southeast-1"

}