resource "aws_iam_instance_profile" "this" {
  for_each = var.instance_profiles
  name     = each.value.name
  role     = each.value.role_name
}

resource "aws_instance" "this" {
  for_each                    = var.instances
  ami                         = each.value.ami_id
  instance_type               = each.value.instance_type
  subnet_id                   = each.value.subnet_id
  associate_public_ip_address = each.value.associate_public_ip_address
  iam_instance_profile        = aws_iam_instance_profile.this["${each.value.instance_profile_key}"].name
  key_name                    = each.value.key_pair_name
  vpc_security_group_ids      = try([for key in each.value.security_groups_keys : aws_security_group.this["${key}"].id], null)
  tags                        = merge({ Name = each.value.name }, each.value.tags)
}
