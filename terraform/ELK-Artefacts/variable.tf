variable "instance_type" {
  default = "t2.micro"
}
variable "ami_id"        {
  default = "ami-51809835"
}

variable "infra_bucket" {
  default = "elk-terraform-remote-state-storage-s3"
}

variable "key_name"     {}

variable "region"  {}
variable "profile" {}

