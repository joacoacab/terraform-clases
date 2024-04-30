resource "aws_instance" "Instancia_Publica" {
    ami = var.ami
    instance_type = var.Tipo_de_Instancia
    subnet_id = aws_subnet.sn_publica_1.id
    associate_public_ip_address = true
    key_name = "terra-istea"

    tags = {
      Name = "Instancia_Publica"
    }
}

resource "aws_instance" "Instancia_Privada" {
    ami = var.ami
    instance_type = var.Tipo_de_Instancia
    subnet_id = aws_subnet.sn_privada_1.id
    associate_public_ip_address = true
    key_name = "terra-istea"
    
    tags = {
      Name = "Instancia_Privada"
    }
}

resource "aws_s3_bucket" "bucket_publico" {
  bucket = "publico"
}

resource "aws_s3_bucket" "bucket_privado" {
  bucket = "privado"
}

resource "aws_s3_bucket_acl" "bucket_publico_acl" {
  bucket = aws_s3_bucket.bucket_publico.id
  acl = "public-read"
}

resource "aws_s3_bucket_acl" "bucket_privado_acl" {
  bucket = aws_s3_bucket.bucket_privado.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket_publico_policy" {
  bucket = aws_s3_bucket.bucket_publico.id
  policy = jsonencode({
    version ="2012-10-17",
    statement = [
        {
            effect      = "Allow",
            Principal   = "*",
            Action      = "s3:GetObject",
            resource    = aws_s3_bucket.bucket_publico.arn
        }
    ]
  })
}

resource "aws_s3_bucket_policy" "bucket_privado_policy" {
  bucket = aws_s3_bucket.bucket_privado.id
  policy = jsonencode({
    version ="2012-10-17",
    statement = [
        {
            effect      = "Deny",
            Principal   = "*",
            Action      = "s3:*",
            resource    = aws_s3_bucket.bucket_privado.arn
        }
    ]
  })
}