resource "aws_security_group" "internal_alb_sg" {
  vpc_id = aws_vpc.my_vpc.id

  # Allow HTTP traffic from NGINX (web tier)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]  # Allow only from web tier
  }


  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF-InternalALBSG"
  }
}
