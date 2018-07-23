variable "instance_type" {
  default = "t2.micro"
}
variable "ami_id"        {
  default = "ami-51809835"
}

variable "infra_bucket" {
  default = "tealbucket1"
}

variable "key_name"     {
  default = "JenkinsKey"
}

variable "region"  {
  default = "eu-west-1"
}
variable "profile" {
  default = "default"
}

