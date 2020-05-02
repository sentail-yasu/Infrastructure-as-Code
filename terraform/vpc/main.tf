provider "aws" {
  region  = "ap-northeast-1"
  version = "2.12.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "tfstate-bucket-ys"
    region  = "ap-northeast-1"
    key     = "vpc/terraform.tfstate"
    encrypt = true
  }
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
}

# Subnet
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-a"]
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-c"]
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1c"
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-a"]
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-c"]
  availability_zone = "ap-northeast-1c"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route" {
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
}

# パブリックルートテーブルと関連付け
resource "aws_route_table_association" "public_a" {
    subnet_id      = aws_subnet.public-a.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
    subnet_id      = aws_subnet.public-c.id
    route_table_id = aws_route_table.public.id
}
