resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "buc003"

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
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
   region     = "eu-west-1"
}



#variable region  {
#   name = "eu-west-1"
#}
#variable profile {
#   name ="default"
#}
