provider "aws" {
  region = var.regionname
}
module "networking" {
  source = "./modules/networking"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  publicsubnet_cidr = var.publicsubnet_cidr
  privatesubnet_cidr = var.privatesubnet_cidr
  alltraffic = var.alltraffic
  az1 = var.az1
  az2 = var.az2

}
module "compute" {
  source = "./modules/compute"
  ami = var.ami
  machinetype = var.machinetype
  keypair =  var.keypair
#  ec2sg = var.ec2sg
#  vpcid = "${module.networking.vpcid}"
  publicsubnetid = "${module.networking.publicsubnetid}"
 # privatesubnetid = "${module.networking.privatesubnetid}"
}
