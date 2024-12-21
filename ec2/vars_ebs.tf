variable "ebs_volumes" {
  type = map(object({
    availability_zone = string
    type              = string
    size              = number
    iops              = number
    throughput        = number
    tags              = map(string)
  }))
  default = {}
}
