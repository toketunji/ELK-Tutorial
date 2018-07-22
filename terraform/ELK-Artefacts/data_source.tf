data "terraform_remote_state" "network_info" {
  backend = "s3"

  config {
    encrypt = "true"
    bucket  = "tealbucket1"
    key     = "Network_routing/terraform.tfstate"
    region  = "eu-west-1"
    profile = "lab"
  }
}

