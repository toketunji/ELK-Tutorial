terraform {
 backend "s3" {
 encrypt = true
 bucket = "${var.infra_bucket}}"
 region = "eu-west-2"
 key = "Network_routing/terraform.tfstate"
 }
}
