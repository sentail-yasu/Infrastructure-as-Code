data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "vpc/terraform.tfstate"
  }
}

variable "ami_id" {
  default = "ami-0f310fced6141e627"
}

variable "instance_count" {
  default = 1
}

variable "public_subnets" {
  default = {
    "0" = data.terraform_remote_state.vpc.outputs.subnet_public_a_id
    "1" = data.terraform_remote_state.vpc.outputs.subnet_public_c_id
  }
}
variable "private_subnets" {
  default = {
    "0" = data.terraform_remote_state.vpc.outputs.subnet_private_a_id
    "1" = data.terraform_remote_state.vpc.outputs.subnet_private_c_id
  }
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_pair" {
  default = "s3_test"
}

variable "app_name" {
  default = "ys-dev-web"
}

variable "bastion_name" {
  default = "ys-dev-bastion"
}
