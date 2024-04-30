resource "aws_vpc" "istea_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
      Name = "prueba_istea_1"
    }
  
}


resource "aws_subnet" "sn_publica_1" {
    vpc_id = aws_vpc.istea_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "sn_publica_1"
    }
}



resource "aws_subnet" "sn_privada_1" {
    vpc_id = aws_vpc.istea_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "sn_privada_1"
    }
}



resource "aws_internet_gateway" "ig_publica_1" {
    vpc_id = aws_vpc.istea_vpc.id
    

    tags = {
      Name = "ig_publica_1"
    }
  
}

resource "aws_route_table" "rt_publica_1" {
    vpc_id = aws_vpc.istea_vpc.id

    tags = {
      Name = "rt_publica_1"
    }
}
  


resource "aws_route" "acceso_internet" {
    route_table_id = aws_route_table.rt_publica_1.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_publica_1.id 
}


resource "aws_route_table_association" "association_publica_1" {
    subnet_id      = aws_subnet.sn_publica_1.id
    route_table_id = aws_route_table.rt_publica_1.id
}

resource "aws_eip" "istea_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ntgw_istea" {
  allocation_id = aws_eip.istea_eip.id
  subnet_id = aws_subnet.sn_publica_1.id

  tags = {
    Name = "ntgw_istea"
  }
}

resource "aws_route_table" "rt_privada_1" {
    vpc_id = aws_vpc.istea_vpc.id

    tags = {
      Name = "rt_privada_1"
    }
}

resource "aws_route" "solo_salida_internet" {
    route_table_id = aws_route_table.rt_privada_1.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ntgw_istea.id
}

resource "aws_route_table_association" "association_privada_1" {
    subnet_id      = aws_subnet.sn_privada_1.id
    route_table_id = aws_route_table.rt_privada_1.id
}