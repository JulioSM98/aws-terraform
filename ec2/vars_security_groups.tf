variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string

    ingress = map(object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    }))

    egress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    tags = map(string)
  }))
  default = {}
}

variable "ingress_rules" {
  type = map(object({
    security_group_key            = string
    ip_protocol                   = string
    from_port                     = string
    to_port                       = string
    cidr_ipv4                     = string
    referenced_security_group_key = string
  }))
  default = {}
}

variable "egress_rules" {
  type = map(object({
    security_group_key            = string
    ip_protocol                   = string
    from_port                     = number
    to_port                       = number
    cidr_ipv4                     = string
    referenced_security_group_key = string
  }))
  default = {}
}
