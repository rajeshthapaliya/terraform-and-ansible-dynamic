resource "aws_vpc" "abcvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "dellvpc"
  }
}

resource "aws_subnet" "abcsubnet" {
  vpc_id                  = aws_vpc.abcvpc.id
  cidr_block              = var.abcsubnet
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "abcsubnet"
  }
}

resource "aws_internet_gateway" "abcigw" {
  vpc_id = aws_vpc.abcvpc.id

  tags = {
    Name = "abcigw"
  }
}

resource "aws_route_table" "abcroutetable" {
  vpc_id = aws_vpc.abcvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.abcigw.id
  }
  tags = {
    Name = "dellpublicroutetable"
  }
}

resource "aws_route_table_association" "abcassociation" {
  subnet_id      = aws_subnet.abcsubnet.id
  route_table_id = aws_route_table.abcroutetable.id
}

resource "aws_security_group" "abcsg" {
  name        = "mysg"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.abcvpc.id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "abcsg"
  }
}