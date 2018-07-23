terraform {
 backend "s3" {
 encrypt = true
 bucket = "buc003"
 region = "eu-west-2"
 key = "Network_routing/terraform.tfstate"
 }
}
