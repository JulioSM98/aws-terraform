resource "aws_s3_bucket" "this" {
  for_each = var.s3_buckets

  bucket        = each.value.bucket
  tags          = each.value.tags
  force_destroy = each.value.force_destroy
}

resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.s3_bucket_public_access_block

  bucket                  = aws_s3_bucket.this["${each.value.s3_bucket_key}"].id
  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}


resource "aws_s3_bucket_ownership_controls" "this" {
  for_each = var.s3_bucket_ownership_controls

  bucket = aws_s3_bucket.this["${each.value.s3_bucket_key}"].id
  rule {
    object_ownership = each.value.rule.object_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  for_each = var.s3_bucket_acl

  bucket = aws_s3_bucket.this["${each.value.s3_bucket_key}"].id
  acl    = each.value.acl

}

data "aws_iam_policy_document" "this" {
  for_each = var.iam_policy_document

  dynamic "statement" {
    for_each = each.value
    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      effect    = statement.value.effect
      resources = statement.value.resources
      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
      dynamic "condition" {
        for_each = statement.value.conditions
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  for_each = { for i, policy in local.s3_bucket_policy : "${policy.s3_bucket_key}-${i}" => policy }

  bucket = aws_s3_bucket.this["${each.value.s3_bucket_key}"].id
  policy = data.aws_iam_policy_document.this["${each.value.policy_key}"].json
}

resource "aws_s3_bucket_cors_configuration" "this" {
  for_each = var.s3_bucket_cors_configuration

  bucket = aws_s3_bucket.this["${each.value.s3_bucket_key}"].id
  dynamic "cors_rule" {
    for_each = each.value.cors_rules
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}
