data "template_file" "elastic_data" {
  template = "${file("template/elastic-data.tpl")}"

}


data "template_file" "kibana_data" {
  template = "${file("template/kibana-data.tpl")}"

}

resource "aws_instance" "Elasticsearch" {
  instance_type               = "t2.micro"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true 
  ebs_optimized               = false
  key_name                    = "${var.key_name}"
  user_data                   = "${data.template_file.elastic_data.rendered}"
 #user_data                   = "${template_file.elastic_data.rendered}"
  subnet_id                   = "${data.terraform_remote_state.network_info.aws_elk_public_subnet}"
  vpc_security_group_ids      = ["${aws_security_group.elasticsearch_allow.id}"]

  tags {
    Name = "Elastic search"
  }
}

resource "aws_instance" "kibana" {
  instance_type               = "t2.micro"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true 
  ebs_optimized               = false
  key_name                    = "${var.key_name}"
  user_data                   = "${data.template_file.kibana_data.rendered}"
  subnet_id                   = "${data.terraform_remote_state.network_info.aws_elk_public_subnet}"
  vpc_security_group_ids      = ["${aws_security_group.elasticsearch_allow.id}"]

  tags {
    Name = "Kibana"
  }
}

resource "aws_security_group" "elasticsearch_allow" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.terraform_remote_state.network_info.elkvpc}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "Kibana/Elastic search SG"
  }
}

