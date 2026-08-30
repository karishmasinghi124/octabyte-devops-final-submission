terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
  # Configure an S3 backend + DynamoDB lock table for shared state.
  # backend "s3" {
  #   bucket         = "REPLACE_WITH_STATE_BUCKET"
  #   key            = "octabyte/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "REPLACE_WITH_LOCK_TABLE"
  #   encrypt        = true
  # }
}
