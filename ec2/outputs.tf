
output "lb_address" {
  value = {
    for k, v in aws_lb.this : k => v.dns_name
  }
}

output "lb_arn" {
  value = {
    for k, v in aws_lb.this : k => v.arn
  }
}

output "lb_zone_id" {
  value = {
    for k, v in aws_lb.this : k => v.zone_id
  }
}

output "tg_arn" {
  value = {
    for k, v in aws_lb_target_group.this : k => v.arn
  }
}

output "sg_id" {
  value = {
    for k, v in aws_security_group.this : k => v.id
  }
}
