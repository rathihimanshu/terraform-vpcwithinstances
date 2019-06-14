output "vpcid" {
  value = "${aws_vpc.myvpc.id}"
}
output "publicsubnetid" {
  value = "${aws_subnet.publicsubnet.id}"
}
output "privatesubnetid" {
  value = "${aws_subnet.privatesubnet.id}"
}