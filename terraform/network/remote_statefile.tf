terraform {
 backend "s3" {
 encrypt = true
 bucket = "buc003"
 region = "eu-west-1"
 key = "Network_routing/terraform.tfstate"
 }
}
