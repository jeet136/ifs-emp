
# terraform {
#   required_version = ">= 0.15"

#   backend "s3" {
#     bucket               = "sgintl-jitesh-mumbai"
#     workspace_key_prefix = "remote-state/sgintl"
#     key                  = "econtracting-lambda/terraform.tfstate"
#     dynamodb_table       = "terraform-state-lock"
#     region               = "ap-south-1"
#   }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }
# provider "aws" {
#   region     = "ap-south-1"
# }