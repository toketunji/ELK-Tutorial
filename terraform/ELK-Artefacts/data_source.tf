data "terraform_remote_state" "network_info" {
  backend = "s3"

  config {
    encrypt = "true"
    bucket  = "tealbucket"
    key     = "Network_routing/terraform.tfstate"
    region  = "eu-west-2"
    profile = "lab"
  }
}

