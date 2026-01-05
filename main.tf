terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "devops_sg" {
  name_prefix = "devops-week2-"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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

  tags = {
    Name = "devops-week2-sg"
  }
}

resource "aws_instance" "devops_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = <<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y docker.io jq curl
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
docker pull somesha/nginx-app:latest
docker run -d -p 80:80 --name nginx-app --restart unless-stopped somesha/nginx-app:latest
echo "IaC Success!" > /home/ubuntu/status.log
EOF

  tags = {
    Name = "Somesha-Terraform-Week2"
  }
}

output "public_ip" {
  value = aws_instance.devops_server.public_ip
}

