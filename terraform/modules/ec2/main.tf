resource "aws_instance" "abcinstance" {
  ami           = var.ami
  instance_type = var.instance_type
  count = var.instance_count
  key_name = var.key_name
  subnet_id     = var.subnet_id
  security_groups = [var.security_group]


  tags = {
    Name = "abcinstance"
  }
}