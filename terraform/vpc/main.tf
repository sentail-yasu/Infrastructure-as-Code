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
  tags {
    Name = "ys-vpc"
  }
}

# Subnet
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-a"]
  availability_zone = "ap-northeast-1a"

  tags {
    Name = var.subnet_name_tag["public-a"]
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-c"]
  availability_zone = "ap-northeast-1c"

  tags {
    Name = var.subnet_name_tag["public-c"]
  }
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-a"]
  availability_zone = "ap-northeast-1a"

  tags {
    Name = var.subnet_name_tag["private-a"]
  }
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-c"]
  availability_zone = "ap-northeast-1c"

  tags {
    Name = var.subnet_name_tag["private-c"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name_tag
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.rt_name_tag
  }
}

resource "aws_route" "route" {
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
}
