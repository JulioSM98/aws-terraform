resource "aws_ebs_volume" "this" {
  for_each = var.ebs_volumes

  availability_zone = each.value.availability_zone
  type              = each.value.type
  size              = each.value.size
  iops              = each.value.iops
  throughput        = each.value.throughput
  tags              = each.value.tags

}
