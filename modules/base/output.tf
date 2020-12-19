output "partner_iam_user" {
  value = aws_iam_user.partner_iam.name
}

output "partner_access_key" {
  value = aws_iam_access_key.partner_access_key.id
}

output "partner_bucket" {
  value = aws_s3_bucket.partner-bucket.bucket
}
