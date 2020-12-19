resource "aws_s3_bucket" "partner-bucket" {
  bucket = "${var.partner}-partner-${var.github-username}"
  acl    = "private"

  tags = {
    OwnedBy        = "Terraform"
    cost-center    = "data-sharing"
    "source"       = var.github-url
  }

}
