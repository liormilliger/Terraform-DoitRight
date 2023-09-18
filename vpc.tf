resource "aws_vpc" "liorm-TF-easy-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "liorm-TF-easy"
  }
}

resource "aws_subnet" "liorm-TF-easy-us-east-1a" {
  vpc_id                  = aws_vpc.liorm-TF-easy-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "liorm-TF-easy-us-east-1a"
  }
}

resource "aws_subnet" "liorm-TF-easy-us-east-1b" {
  vpc_id                  = aws_vpc.liorm-TF-easy-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "liorm-TF-easy-us-east-1b"
  }
}

resource "aws_internet_gateway" "liorm-TF-easy-igw" {
  vpc_id = aws_vpc.liorm-TF-easy-vpc.id
  tags = {
    Name = "liorm-TF-easy-igw"
  }
}


resource "aws_route_table" "liorm-TF-easy-RT" {
  vpc_id = aws_vpc.liorm-TF-easy-vpc.id

  tags = {
    Name = "liorm-TF-easy-RT"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.liorm-TF-easy-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.liorm-TF-easy-igw.id
}

resource "aws_route_table_association" "liorm-TF-easy-pub-assoc-1a" {
  subnet_id      = aws_subnet.liorm-TF-easy-us-east-1a.id
  route_table_id = aws_route_table.liorm-TF-easy-RT.id
}

resource "aws_route_table_association" "liorm-TF-easy-pub-assoc-1b" {
  subnet_id      = aws_subnet.liorm-TF-easy-us-east-1b.id
  route_table_id = aws_route_table.liorm-TF-easy-RT.id
}

resource "aws_security_group" "liorm-TF-easy-SG" {
  name        = "liorm-TF-easy-SG"
  description = "Allow incoming HTTP traffic from your IP"
  vpc_id      = aws_vpc.liorm-TF-easy-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.KARMI_IP}", "${var.HOME_IP}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "liorm-tf-key" {
  key_name   = "liorm-tf-key"
  public_key = file("~/.ssh/liorm-tf-key_rsa.pub")
}