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

# This DATA SOURCE finds the existing S3 bucket
data "aws_s3_bucket" "example" {
  bucket = "projeto-ai-testing-helper"
}

output "bucket_name" {
  value = data.aws_s3_bucket.example.bucket
}

# This DATA SOURCE finds the existing security group
data "aws_security_group" "chatbot_sg" {
  name = "chatbot-gemini-sg"
}

resource "aws_instance" "chatbot_gemini" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  key_name      = "AI_Testing_H"

  # The instance uses the ID from the existing security group
  vpc_security_group_ids = [data.aws_security_group.chatbot_sg.id]

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