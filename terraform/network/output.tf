output "elkvpc" {
    value =  "${aws_vpc.elk.id}"
}  


output "aws_elk_public_subnet" {
    value =  "${aws_subnet.elkpublic_subnet.id}"
}  

