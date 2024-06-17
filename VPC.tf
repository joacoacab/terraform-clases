provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16" 
  instance_tenancy = "default"      
  tags = {
    Name = "MiVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"       
  availability_zone = "us-east-1a"
  tags = {
    Name = "RedPublica"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.test_vpc.id 
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id  
  cidr_block = "10.0.2.0/24"       
  availability_zone = "us-east-1b" 
  tags = {
    Name = "RedPrivada"
  }
}

resource "aws_eip" "elastic_ip" {}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.private_subnet.id
}
