resource "aws_instance" "ins-1" {

  ami = var.ami
  count = 2
  instance_type = var.machinetype
  key_name = var.keypair
  subnet_id = var.publicsubnetid
  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd curl
    service httpd start
    chkconfig httpd on
    export INSTANCE_ID = curl http://169.254.169.254/latest/meta-data/instance-id
    echo "<body bgcolor="#FFFF00"><center><h1>$INSTANCE_ID</h1></center></body>" > /var/www/html/index.html
  EOF
  tags = {
    Name = "mymachine-${count.index}"
  }
}
/*
resource "aws_security_group" "ec2-sg" {
  name = var.ec2sg
  vpc_id = var.vpcid

}
*/
