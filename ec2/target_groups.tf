resource "aws_lb_target_group" "this" {
  for_each = var.lb_target_groups

  name                 = each.value.name
  port                 = each.value.port
  protocol             = each.value.protocol
  vpc_id               = each.value.vpc_id
  target_type          = each.value.target_type
  protocol_version     = each.value.protocol_version
  deregistration_delay = each.value.deregistration_delay
  tags                 = each.value.tags

  health_check {
    port                = each.value.health_check.port
    path                = each.value.health_check.path
    protocol            = each.value.health_check.protocol
    healthy_threshold   = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
    interval            = each.value.health_check.interval
    timeout             = each.value.health_check.timeout
  }

}


