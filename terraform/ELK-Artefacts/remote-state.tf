terraform {
 backend "s3" {
 encrypt = true
 bucket = "tealbucket"
 region = "eu-west-1"
 key = "elknodes/terraform.tfstate"
 }
}
