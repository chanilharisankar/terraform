provider "aws" {
  region = "us-east-1"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = ["192.168.1.0/24"]
  name        = "learning"
}

module "my_ec2" {
  source        = "../modules/ec2"
  subnet_id     = "${module.my_vpc.subnet_id}"
  instance_type = "t2.nano"
  ami_id        = "ami-00068cd7555f543d5"
  security_groups = ["${module.my_vpc.security_group_id}"]
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${module.my_vpc.vpc_id}"

  tags = {
    Name = "learning-ig"
  }
}
output "name" {
  value = "${module.my_vpc.security_group_id}"
}
