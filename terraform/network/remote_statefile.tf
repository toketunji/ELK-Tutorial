terraform {
 backend "s3" {
 encrypt = true
 bucket = "bucket001"
 region = "eu-west-2"
 key = "Network_routing/terraform.tfstate"
 }
}
