# Security Group

resource "aws_security_group" "ecomm-app" {
  name        = "allow ecomm"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = aws_vpc.ecomm.id

  ingress {
    description      = "SSH from www"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from www"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow ecomm"
  }
}

