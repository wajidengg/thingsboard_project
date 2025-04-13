provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "thingsboard_sg" {
  name        = "thingsboard-sg"
  description = "Security group for ThingsBoard"

  # MQTT
  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # CoAP
  ingress {
    from_port   = 5683
    to_port     = 5683
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ThingsBoard Web UI
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH Access 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "thingsboard_ec2" {
  ami                    = "ami-0f9de6e2d2f067fca" 
  instance_type          = "t2.medium"
  key_name               = "vockey" 
  vpc_security_group_ids = [aws_security_group.thingsboard_sg.id]
  subnet_id              = "subnet-0eab217423de0f958"
  associate_public_ip_address = true 

  user_data = file("scripts/install_thingsboard.sh") 

  tags = {
    Name = "ThingsBoard"
  }
}

output "public_ip" {
  description = "Public IP of the ThingsBoard EC2 instance"
  value       = aws_instance.thingsboard_ec2.public_ip
}
