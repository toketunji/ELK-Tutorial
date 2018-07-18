#provider "aws" {
  #region  =  "${var.region}"
 # profile  = "${var.profile}"
#}

#####Create VPC  for ELK ##################

resource "aws_vpc" "elk" {
  cidr_block = "10.0.0.0/24"

  tags {
    Name = "ELK VPC"
  }
}


############# we wiill be provisioning 2 subnets; private and public  ################


resource "aws_subnet" "elkpublic_subnet" {
  vpc_id     = "${aws_vpc.elk.id}"
  cidr_block = "10.0.0.0/28"

  tags {
    Name = "ELK_Public"
  }
}


resource "aws_subnet" "elkprivate_subnet" {
  vpc_id     = "${aws_vpc.elk.id}"
  cidr_block = "10.0.0.112/28"

  tags {
    Name = "ELK_Private"
  }
}







