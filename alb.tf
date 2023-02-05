# Create an Application Load Balancer
resource "aws_lb" "application-load-balancer" {
  name            = "loadbalancer"
  internal        = false
  security_groups = [aws_security_group.alb-security-group.id]
  subnets         = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  enable_deletion_protection = false
  depends_on                 = [aws_instance.ec2-instance-1, aws_instance.ec2-instance-2, aws_instance.ec2-instance-3]
}

# Create the target group
resource "aws_lb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create the listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

# Create the listener rule
resource "aws_lb_listener_rule" "alb-listener-rule" {
  listener_arn = aws_lb_listener.alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


# Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "alb-target-group-attachment-1" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.ec2-instance-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb-target-group-attachment-2" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.ec2-instance-2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb-target-group-attachment-3" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.ec2-instance-3.id
  port             = 80
}