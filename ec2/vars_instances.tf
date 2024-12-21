variable "instances" {
  type = map(object({
    name                        = string
    ami_id                      = string
    instance_type               = string
    subnet_id                   = string
    associate_public_ip_address = bool
    instance_profile_key        = string
    key_pair_name               = string
    security_groups_keys        = list(string)
    tags                        = map(string)
  }))
  default = {}
}

variable "instance_profiles" {
  type = map(object({
    name      = string
    role_name = string
  }))
  default = {}
}