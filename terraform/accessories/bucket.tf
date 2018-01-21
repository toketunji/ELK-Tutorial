resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "elk-terraform-remote-state-storage-s3"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "S3 Remote Terraform State Store"
    }
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}


variable region  {}
variable profile {}
