resource "aws_instance" "web" {
  count         = "${length(var.subnet_id)}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id[count.index]}"
  security_groups = "${var.security_groups}"

  tags = {
    Name = "my ec2 - ${count.index + 1}"
  }
}
