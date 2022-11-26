# EC2 server
resource "aws_instance" "ecomm-ec2" {
  ami                       = "ami-074dc0a6f6c764218"
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.ecomm-sn.id
  vpc_security_group_ids    = [aws_security_group.ecomm-app.id]
  key_name                  = "tcs-mumbai"
  user_data = <<EOF
  #! /bin/sh
  yum update -y
  amazon-linux-extras install docker -y
  service docker start
  usermod -a -G docker ec2-user
  chkconfig docker on

  sudo yum install git -y

  sudo git clone https://github.com/ravi2krishna/ecomm.git website/

  cat <<EOF >Dockerfile
  FROM httpd:2.4
  COPY ./website/ /usr/local/apache2/htdocs/
  EOF

  docker build -t apache-docker-ecomm .
  docker run -d --name httpd-docker-01 -p 80:80 apache-docker-ecomm

  EOF


  tags = {
    Name = "ecomm server"
  }

}
