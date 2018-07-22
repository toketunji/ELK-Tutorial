terraform {
 backend "s3" {
 encrypt = true
 bucket = "tealbucket1"
 region = "eu-west-1"
 key = "Network_routing/terraform.tfstate"
 }
}
