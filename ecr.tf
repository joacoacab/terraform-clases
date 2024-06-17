resource "aws_ecr_repository" "ecr_repository" {
  name = "prueba-repo-ecr"
  image_tag_mutability = "IMMUTABLE" 
  image_scanning_configuration {
      scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
    repository = aws_ecr_repository.ecr_repository.name
    policy = <<EOF
    {
        "Version": "2008-10-17",
        "Statement": [
            {
                "Sid": "AllowAll",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "ecr:*"
            }
        ]
    }
EOF
}

data "aws_ecr_authorization_token" "ecr_toker" {}

output "docker_login_cmd" {
    value = data.aws_ecr_authorization_token.ecr_toker.authorization_token
    sensitive = true
}

resource "null_resource" "pull_image" {
    provisioner "local-exec" {
        command = "docker build -t ${aws_ecr_repository.ecr_repository.repository_url}:latest"
    }
}
