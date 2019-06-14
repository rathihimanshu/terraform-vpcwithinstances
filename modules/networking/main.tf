resource "aws_vpc" "myvpc" {

  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "publicsubnet" {

  cidr_block = var.publicsubnet_cidr
  vpc_id = "${aws_vpc.myvpc.id}"
  availability_zone = var.az1
  map_public_ip_on_launch = true
}
resource "aws_subnet" "privatesubnet" {

  cidr_block = var.privatesubnet_cidr
  vpc_id = "${aws_vpc.myvpc.id}"
  availability_zone = var.az2
}
resource "aws_internet_gateway" "vpc_ig" {
  vpc_id = "${aws_vpc.myvpc.id}"
}
resource "aws_route_table" "publicroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = var.alltraffic
    gateway_id = "${aws_internet_gateway.vpc_ig.id}"
  }

  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table_association" "publicassociation" {

  route_table_id = "${aws_route_table.publicroute.id}"
  subnet_id = "${aws_subnet.publicsubnet.id}"
}
resource "aws_route_table" "privateroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "privateroute"
  }
}
resource "aws_route_table_association" "privateassociation" {

  route_table_id = "${aws_route_table.privateroute.id}"
  subnet_id = "${aws_subnet.privatesubnet.id}"
}
