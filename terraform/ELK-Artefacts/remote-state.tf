terraform {
 backend "s3" {
 encrypt = true
 bucket = "bucket001"
 region = "eu-west-2"
 key = "elknodes/terraform.tfstate"
 }
}
