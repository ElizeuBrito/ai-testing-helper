terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.3.0"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
    bucket = "projeto-final-ia-testing_helper"
    acl    = "private"
}

output "bucket_name" {
    value = aws_s3_bucket.example.bucket
}

resource "aws_security_group" "chatbot_sg" {
  name        = "chatbot-gemini-sg"
  description = "Permite acesso SSH e HTTP para Streamlit"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Streamlit"
    from_port   = 8501
    to_port     = 8501
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

resource "aws_instance" "chatbot_gemini" {
  ami           = "ami-0fc61db8544a617ed" # Ubuntu Server 22.04 LTS (verifique se há uma mais recente)
  instance_type = "t2.micro"
  key_name      = "AI_Testing_H"          # Substitua pelo nome do seu key pair

  vpc_security_group_ids = [aws_security_group.chatbot_sg.id]

  tags = {
    Name = "Chatbot-Gemini"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip python3-venv git
    git clone https://github.com/ElizeuBrito/ai-testing-helper.git /home/ubuntu/projeto-final-ia
    cd /home/ubuntu/projeto-final-ia
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    nohup streamlit run main.py --server.port 8501 --server.address 0.0.0.0 &
  EOF
}

output "instance_public_ip" {
  value = aws_instance.chatbot_gemini.public_ip
}