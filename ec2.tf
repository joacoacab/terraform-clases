resource "aws_instance" "public_instance" {
    ami = "ami-080e1f13689e07408"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    key_name = "mykeys"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.security_group.id]
    tags = {
        Name = "InstanciaPublica"
    }
}

resource "aws_security_group" "security_group" {
  name        = "mi-security-group"
  description = "PlsHelp"

  vpc_id = aws_vpc.test_vpc.id  # ID de la VPC a la que pertenece el grupo de seguridad

  // Reglas de entrada (inbound)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permite el tráfico HTTP desde cualquier origen
  }

  // Reglas de salida (outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite todo el tráfico saliente
  }
}


resource "aws_instance" "private_instance" {
    ami = "ami-0fe630eb857a6ec83"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet.id
    tags = {
        Name = "InstanciaPrivada"
    }
}
