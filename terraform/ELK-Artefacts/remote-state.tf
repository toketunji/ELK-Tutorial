terraform {
 backend "s3" {
 encrypt = true
 bucket = "tealbucket"
 region = "eu-west-2"
 key = "elknodes/terraform.tfstate"
 }
}
