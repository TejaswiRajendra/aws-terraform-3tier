resource "aws_instance" "nginx" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = "mynewkey"
  

  user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install -y nginx
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    Name = "public-Tf-nginx"
  }

}

resource "aws_instance" "flask_app" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = "mynewkey"
  

  user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install -y python3 python3-pip
  pip3 install flask mysql-connector-python
  EOF

  tags = {
    Name = "private-TF-flaskapp"
  }

}
