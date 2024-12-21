resource "aws_route53_record" "record" {
  for_each = var.records
  zone_id  = each.value.zone_id
  name     = each.value.name
  type     = each.value.type

  dynamic "alias" {
    for_each = each.value.alias != null ? [each.value.alias] : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.health
    }
  }
  records = each.value.records
  ttl = each.value.ttl

  

}
