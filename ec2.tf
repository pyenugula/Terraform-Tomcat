# Provider configuration
provider "aws" {
  profile = "default"
  region = "ap-south-1"
  version = "~> 2.10"
}

#Deploy Ec2 instance using aws resource

resource "aws_instance" "my-ec2" {
  ami = "ami-0732b62d310b80e97"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-ec2-sg.id]

  # boot straping

  user_data = <<-EOF
              #! /bin/bash
              sudo yum install -y httpd git
              sudo service httpd start
              sudo chkconfig httpd on
              cd /var/www/html
              sudo git clone https://github.com/sreesysadm/carwebsite.git .
              sudo service httpd restart
              EOF
  tags = {

    Name = "terraform-tomcat"
  }
}

#Security group

resource "aws_security_group" "my-ec2-sg" {
  name = "terraform-webserver-sg"

  #Receive Trafic on port 80

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  #outgoing trafic

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}