variable "ami_id" {
  default = "ami-0f310fced6141e627"
}

variable "instance_count" {
  default = 1
}

variable "public_subnets" {
  default = {
<<<<<<< HEAD
    "0" = "subnet-0e5c9e24559a2bc69"
    "1" = "subnet-0d3cf3ee80f2343ad"
  }
}
variable "private_subnets" {
  default = {
    "0" = "subnet-0814e4fe2afac3424"
    "1" = "subnet-03156f0e99491e983"
=======
    "0" = "subnet-0a29747fa51caf8f6"
    "1" = "subnet-0914faa9517e5aab8"
>>>>>>> 71e8a99fd1b53c15a6926ba624fe3dc17d8f2af6
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
