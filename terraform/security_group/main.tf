provider "aws" {
  region  = "ap-northeast-1"
  version = "2.12.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "security_group/terraform.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "vpc/terraform.tfstate"
  }
}

# bastionに設定するセキュリティグループ
resource "aws_security_group" "bastion_security_group" {
  name   = "${var.bastion_name}-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.bastion_name}-sg"
  }
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_security_group.id
}

# private_subnets EC2 に設定するセキュリティグループ
resource "aws_security_group" "web_security_group" {
  name   = "${var.app_name}-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_security_group.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-sg"
  }
}

output "web_sg_id" {
  value = aws_security_group.web_security_group.id
}

# ロードバランサーに設定するセキュリティグループ
resource "aws_security_group" "lb_security_group" {
  name   = "${var.app_name}-lb-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-lb-sg"
  }
}

output "lb_sg_id" {
  value = aws_security_group.lb_security_group.id
}

# RDSに設定するセキュリティグループ
resource "aws_security_group" "db_security_group" {
  name   = "${var.app_name}-db-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.web_security_group.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-db-sg"
  }
}

output "db_sg_id" {
  value = aws_security_group.db_security_group.id
}
