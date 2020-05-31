resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "main" {
  count      = "${length(var.subnet_cidr)}"
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr[count.index]}"

  tags = {
    Name = "${var.name}-subnet-${count.index + 1}"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet_id" {
  value = "${aws_subnet.main.*.id}"
}



