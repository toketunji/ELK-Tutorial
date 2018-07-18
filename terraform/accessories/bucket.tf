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
  region  = "eu-west-1"
  profile = "default"
}


variable region  {}
variable profile {}
