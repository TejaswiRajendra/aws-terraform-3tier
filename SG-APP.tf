resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group for Flask application servers"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb_sg.id]  # Allow only from ALB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
