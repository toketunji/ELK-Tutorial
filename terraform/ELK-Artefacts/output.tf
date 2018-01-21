output "elasticsearch nodes" {
  value = "${aws_instance.Elasticsearch.public_ip}"
}


output "kibana nodes" {
  value = "${aws_instance.kibana.public_ip}"
}

#output "elasticsearch private nodes" {
#  value = "${aws_instance.Elasticsearch.private_ip}"
#
#}
