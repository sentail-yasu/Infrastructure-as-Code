variable "ami_id" {
  default = "ami-0f310fced6141e627"
}

variable "instance_count" {
  default = 1
}

variable "public_subnets" {
  default = {
    "0" = "subnet-0929a1e0441aab25d"
    "1" = "subnet-046ddf779f2cb818d"
  }
}
variable "private_subnets" {
  default = {
    "0" = "subnet-0435f5ad9dffbdefb"
    "1" = "subnet-0475a95c81d3f5e80"
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
