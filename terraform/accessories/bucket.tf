resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "tealbucket"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "TEAL O Terraform State Store"
    }
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}


variable region  {}
variable profile {}
