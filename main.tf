provider "aws" {
  region = "us-east-1" 
}

resource "aws_security_group" "thingsboard_sg" {
  name        = "thingsboard-sg"
  description = "Security group for ThingsBoard"

  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5683
    to_port     = 5683
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "thingsboard_ec2" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"             
  key_name      = "vockey"               
  security_group_ids     = [aws_security_group.thingsboard_sg.id]

  user_data = file("scripts/install_thingsboard.sh") 

  tags = {
    Name = "ThingsBoard"
  }
}

output "public_ip" {
  value = aws_instance.thingsboard_ec2.public_ip
}