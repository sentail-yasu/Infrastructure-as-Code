variable "ami_id" {
  default = "ami-08360a37d07f61f88"
}

variable "instance_count" {
  default = 1
}

variable "subnets" {
  default = {
    "0" = "subnet-0e5c9e24559a2bc69"
    "1" = "subnet-0d3cf3ee80f2343ad
"
  }
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_pair" {
  default = "s3_test"
}

variable "app_name" {
  default = "ys-app"
}
