variable "lbs" {
  type = map(object({
    name                             = string
    subnets                          = list(string)
    load_balancer_type               = string
    internal                         = bool
    enable_cross_zone_load_balancing = bool
    security_groups_keys             = list(string)
    idle_timeout                     = number
    tags                             = map(string)
  }))
  default = {}
}

variable "lb_listeners" {
  type = map(object({
    load_balancer_key        = string
    load_balancer_arn        = string
    port                     = string
    protocol                 = string
    certificate_arn          = string
    ssl_policy               = string
    tcp_idle_timeout_seconds = number
    default_action = object({
      type             = string
      target_group_key = string
      redirect = list(object({
        port        = string
        protocol    = string
        status_code = string
      }))

    })
    tags = map(string)
  }))
  default = {}
}

variable "lb_listener_rules" {
  type = map(object({
    listener_arn_key = string
    priority         = number
    actions = list(object({
      type                 = string
      target_group_arn_key = string
    }))

    conditions = list(object({

      path_pattern = object({
        values = list(string)
      })

      host_header = object({
        values = list(string)
      })

    }))

    tags = map(string)

  }))
  default = {}
}
