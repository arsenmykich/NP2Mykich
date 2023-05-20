provider "aws" {
  access_key = "AKIAY3ZJP33Z*******" #приховав ключ для гітхабу
  secret_key = "ZH4SfIzwezglVsTUy5XhbcL********"
  region     = "eu-north-1"
}

resource "aws_vpc" "ter" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "ter" {
  vpc_id                  = aws_vpc.ter.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.aws_availability_zone
}

resource "aws_security_group" "ter" {
  name        = "ter-security-group"
  description = "ter Security Group"
  vpc_id      = aws_vpc.ter.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "firstServer" {
  ami                    = "ami-0a79730daaf45078a"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.ter.id
  vpc_security_group_ids = [aws_security_group.ter.id]
  key_name               = "ArsenMykich"

  user_data = <<-EOF
    #!/bin/bash
  
    EOF

  tags = {
    Name = "firstServer"
  }
}

resource "aws_instance" "secondServer" {
  ami                    = "ami-0a79730daaf45078a"
  instance_type          = "t3.micro"
  key_name               = "ArsenMykich"

  tags = {
    Name = "secondServer"
  }
}




