provider "aws" {
  region  = "ap-northeast-1"
  version = "2.12.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "s3/terraform.tfstate"
    encrypt = true
  }
}

# プライベートバケットの定義
resource "aws_s3_bucket" "private" {
  # バケット名は世界で1意にしなければならない
  bucket = "tfstate-bucket-ys-codecommit"

  versioning {
    enabled = true
  }

  # 暗号化を有効
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
