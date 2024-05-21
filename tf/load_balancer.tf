resource "aws_lb" "main_load_balancer" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main_ecs_security_group.id]
  subnets            = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "main_lb_target_group" {
  name     = "main-tg"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "main_lb_listener" {
  load_balancer_arn = aws_lb.main_load_balancer.arn
  port              = "${var.port}"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_lb_target_group.arn
  }
}
