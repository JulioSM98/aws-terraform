variable "s3_buckets" {
  type = map(object({
    bucket             = string
    bucket_policy_keys = list(string)
    tags               = map(string)
    force_destroy      = bool
  }))
}

variable "s3_bucket_public_access_block" {
  type = map(object({
    s3_bucket_key           = string
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  }))
}

variable "s3_bucket_ownership_controls" {
  type = map(object({
    s3_bucket_key = string
    rule = object({
      object_ownership = string
    })
  }))
}

variable "s3_bucket_acl" {
  type = map(object({
    s3_bucket_key = string
    acl           = string
  }))
}

variable "iam_policy_document" {
  type = map(list(object({
    sid       = string
    actions   = list(string)
    effect    = string
    resources = list(string)
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    conditions = list(object({
      test     = string
      variable = string
      values    = list(string)
    }))
  })))
}

variable "s3_bucket_cors_configuration" {
  type = map(object({
    s3_bucket_key = string
    cors_rules = list(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
    }))
  }))
}

locals {
  s3_bucket_policy = [
    for policy in flatten([
      for k, v in var.s3_buckets : [
        for i, arn in zipmap(range(length(v.bucket_policy_keys)), v.bucket_policy_keys) : {
          s3_bucket_key = k
          policy_key    = arn
        }
      ] if v.bucket_policy_keys != null
    ]) : policy
  ]


}
