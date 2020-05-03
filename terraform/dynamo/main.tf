provider "aws" {
  region  = "ap-northeast-1"
  version = "2.12.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "ec2/terraform.tfstate"
    encrypt = true
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "terraform_state_lock"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"      # S = String
  }
}
