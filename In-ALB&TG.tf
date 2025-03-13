resource "aws_lb" "internal_alb" {
  name               = "InternalALB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb_sg.id]
  subnets            = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "TF-InternalALB"
  }
}

resource "aws_lb_target_group" "flask_tg" {
  name     = "flask-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "TF-FlaskTargetGroup"
  }
}

resource "aws_lb_listener" "internal_alb_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "flask_target_attachment" {
  target_group_arn = aws_lb_target_group.flask_tg.arn
  target_id        = aws_instance.flask_app.id
  port             = 5000
}
