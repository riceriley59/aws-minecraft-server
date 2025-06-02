terraform {
  backend "s3" {
    bucket = "riceri-terraform-state-bucket"
    key    = "terraform-state-s3/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "riceri-terraform-state-bucket"
}
