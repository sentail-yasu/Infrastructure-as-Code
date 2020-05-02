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

data "terraform_remote_state" "security_group" {
  backend = "s3"

  config = {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "security_group/terraform.tfstate"
  }
}

resource "aws_instance" "bastion_ec2" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = lookup(var.public_subnets, count.index % 2)
  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.bastion_sg_id]

  tags = {
    Name = "${var.bastion_name}_${count.index + 1}"
  }
}

output "instance_ids_bastion" {
  value = {
    for instance in aws_instance.bastion_ec2 :
    instance.id => instance.public_ip
  }
}

resource "aws_instance" "web_ec2" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = lookup(var.private_subnets, count.index % 2)
  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.web_sg_id]

  tags = {
    Name = "${var.app_name}_${count.index + 1}"
  }
}

output "instance_ids_web" {
  value = {
    for instance in aws_instance.web_ec2 :
    instance.id => instance.private_ip
  }
}

output "instance_count" {
  value = var.instance_count
}
