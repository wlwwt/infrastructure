resource "aws_lb" "main" {
  name               = "${var.app_name}-${var.environment}"
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = module.lb_security_groups.ids
  subnets         = var.subnet_ids

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.app_name}-${var.environment}-${var.group_port}"
  port        = var.group_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  dynamic "health_check" {
    for_each = [local.health_check]

    content {
      enabled             = health_check.value.enabled
      interval            = health_check.value.interval
      path                = health_check.value.path
      port                = health_check.value.port
      protocol            = health_check.value.protocol
      timeout             = health_check.value.timeout
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
      matcher             = health_check.value.matcher
    }
  }

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      health_check[0].path
    ]
  }
}

resource "aws_lb_listener" "http-redirect" {
  count             = var.redirect_to_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.redirect_to_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn

  port            = 443
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "http" {
  count             = var.redirect_to_https ? 0 : 1
  load_balancer_arn = aws_lb.main.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
