resource "aws_iam_user" "partner_iam" {
    name    = "${var.partner}-partner"
    force_destroy = true

    tags = {
      OwnedBy        = "Terraform"
      cost-center    = "data-sharing"
      "source"       = var.github-url
    }
}

resource "aws_iam_access_key" "partner_access_key" {
  user = aws_iam_user.partner_iam.name
}


data "aws_iam_policy_document" "s3_policy_document" {
    statement {
      sid = "1"
      effect = "Allow"

      actions = [
        "s3:PutObject",
      ]

      resources = [
        "arn:aws:s3:::${var.partner}-partner-${var.github-username}/upload/*",
      ]
    }
    statement {
      sid = "2"
      effect = "Deny"

      actions = [
        "s3:ListBucket",
        "s3:GetObject",
      ]

      resources = [
        "arn:aws:s3:::${var.partner}-partner-${var.github-username}",
      ]
      condition {
        test     = "StringLike"
        variable = "s3:prefix"

        values = ["stats/",]
      }
    }
    statement {
      sid = "3"
      effect = "Allow"

      actions = [
        "s3:ListBucket",
        "s3:GetObject",
      ]

      resources = [
        "arn:aws:s3:::${var.partner}-partner-${var.github-username}",
        "arn:aws:s3:::${var.partner}-partner-${var.github-username}/*",
      ]
    }
}

resource "aws_iam_policy" "s3_bucket_policy" {
  name   = "s3-bucket-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_policy_document.json
}

resource "aws_iam_policy_attachment" "s3_policy_attachment" {
  name  = "s3-policy-attachment"
  users = [aws_iam_user.partner_iam.name]
  policy_arn = aws_iam_policy.s3_bucket_policy.arn

}
