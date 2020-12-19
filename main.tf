provider "aws" {
  region = "us-east-1"
  profile = "saa02-general"
  version = "3.0"
}

module "partner" {
  source = "./modules/base"

  partner = "${var.partner}"
  github-url = "${var.github-url}"
  github-username = "${var.github-username}"
}

terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-bucket-pavan26devops"
    key            = "aws/base/terraform.tfstate"
    region         = "us-east-1"
    profile        = "saa02-general"
    dynamodb_table = "pavan26devops-terraform-remote-state-lock"
    encrypt        = true
  }
}
