variable "ami_id" {
  default = "ami-08360a37d07f61f88"
}

variable "instance_count" {
  default = 1
}

variable "subnets" {
  default = {
    "0" = "subnet-000111222"
    "1" = "subnet-333444555"
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
