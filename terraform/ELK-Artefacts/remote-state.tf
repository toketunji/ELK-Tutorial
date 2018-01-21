terraform {
 backend "s3" {
 encrypt = true
 bucket = "elk-terraform-remote-state-storage-s3"
 region = "eu-west-2"
 key = "elknodes/terraform.tfstate"
 }
}
