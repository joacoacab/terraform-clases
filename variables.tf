variable "aws_region" {
  description = "Region de AWS"
  default = "us-east-1"
}

variable "Tipo_de_Instancia" {
  description = "Tipo de instancia EC2"
  default = "t2.micro"
}

variable "ami" {
  description = "ID de la AMI de la instancia EC2 Red Hat"
  default = "ami-0fe630eb857a6ec83"
}



