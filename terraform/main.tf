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
  ami           = "ami-0fc61db8544a617ed" 
  instance_type = "t2.micro"
  key_name      = "AI_Testing_H"

  # The instance uses the ID from the existing security group
  vpc_security_group_ids = [data.aws_security_group.chatbot_sg.id]

  tags = {
    Name = "Chatbot-Gemini"
  }

  user_data = <<-EOF
  #!/bin/bash
  # Use yum for Amazon Linux
  sudo yum update -y
  sudo yum install -y python3 git

  # Git clone and setup
  git clone https://github.com/ElizeuBrito/ai-testing-helper.git /home/ec2-user/projeto-final-ia
  cd /home/ec2-user/projeto-final-ia

  # Use the correct python3 version to create a venv
  python3 -m venv .venv
  source .venv/bin/activate
  
  # Install pip and requirements
  pip install --updgrade pip
  pip install -r requirements.txt
  
  # Install streamlit in the virtual environment
  pip install streamlit

  # Run the application with nohup and redirect output to a log file
  nohup streamlit run main.py --server.port 8501 --server.address 0.0.0.0 &
EOF
}

output "instance_public_ip" {
  value = aws_instance.chatbot_gemini.public_ip
}