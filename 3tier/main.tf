terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = "ap-south-2"
}

terraform {
  backend "s3" {
    bucket = "9281430306"
    key    = "tf-statefiles/3tier-terraform.tfstate"
    region = "ap-south-2"
  }
}

# VPC, IGW, Subnets, NAT, Route Tables

# VPC 
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Public Subnet 
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
}

# Private Subnets For Web Server/WebLayer
resource "aws_subnet" "web" {
  count      = length(var.web_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.web_subnets[count.index]
}

# Private Subnets For App Server/AppLayer
resource "aws_subnet" "app" {
  count      = length(var.app_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_subnets[count.index]
}

# Private Subnets For DB Server/DBLayer
resource "aws_subnet" "data" {
  count      = length(var.data_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.data_subnets[count.index]
}

# Public RTB
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public[0].id
}

# Security Groups for Bastion, Web, App, Data
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main.id
}

# EC2 Instances with Web Server User Data

resource "aws_instance" "web" {
  count           = 2
  ami             = "ami-12345678"
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.web[count.index].id
  key_name        = var.key_name
  security_groups = [aws_security_group.web_sg.name]
  user_data       = file("user_data.sh")
}

resource "aws_instance" "app" {
  count           = 2
  ami             = "ami-12345678"
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.app[count.index].id
  security_groups = [aws_security_group.app_sg.name]
}

# RDS MySQL Instance
resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  db_name                = "mydatabase"
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

output "web_public_ips" {
  value = aws_instance.web[*].public_ip
}


