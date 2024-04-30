provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "istea_sg" {
  vpc_id = aws_vpc.istea_vpc.id
  name = "istea_sg"
  description = "acceso_trafico"

ingress = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Allow HTTP traffic from anywhere"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Allow all outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

tags = {
  Name = "Istea-Security-Group-1"
}
}

resource "aws_security_group" "ssh_access_sg" {
  vpc_id = aws_vpc.istea_vpc.id
  name        = "ssh_access_sg"
  description = "Permitir acceso SSH"

ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Allow SSH traffic from anywhere"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]  
tags = {
  Name = "Istea-Security-Group-2"
}
}

