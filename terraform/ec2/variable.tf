variable "ami_id" {
  default = "ami-0f310fced6141e627"
}

variable "instance_count" {
  default = 1
}

variable "subnets" {
  default = {
    "0" = "subnet-0a29747fa51caf8f6"
    "1" = "subnet-0914faa9517e5aab8"
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
