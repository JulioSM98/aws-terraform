variable "lb_target_groups" {
  type = map(object({
    name                 = string
    port                 = number
    protocol             = string
    vpc_id               = string
    target_type          = string
    protocol_version     = string
    deregistration_delay = string
    tags                 = map(string)
    health_check = object({
      path                = string
      port                = string
      protocol            = string
      healthy_threshold   = number
      unhealthy_threshold = number
      interval            = number
      timeout             = number
    })
  }))
  default = {}
}
