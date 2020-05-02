## VPC Name Tag
variable "vpc_name_tag" {
  default = "terraform-import-vpc"
}

## Subnet
variable "subnet_cidr" {
  type = "map"

  default = {
    public-a  = "10.1.10.0/24"
    public-c  = "10.1.20.0/24"
    private-a = "10.1.100.0/24"
    private-c = "10.1.200.0/24"
  }
}
## Subnet Name Tag
variable "subnet_name_tag" {
  type = "map"

  default = {
    public-a  = "terraform-import-public-subnet-a"
    public-c  = "terraform-import-public-subnet-c"
    private-a = "terraform-import-private-subnet-a"
    private-c = "terraform-import-private-subnet-c"
  }
}
