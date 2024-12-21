variable "ssm_parameters" {
  type = map(object({
    name        = string
    description = string
    type        = string
    value       = string
    tags        = map(string)
  }))
}

variable "data_ssm_parameters" {
  type = map(object({
    name = string
  }))
}
