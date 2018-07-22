resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "bucket001"

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

#provider "aws" {
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
#  region     = "eu-west-2"
#}



variable region  {
   name = "eu-west-2"
}
variable profile {
   name ="default"
}
