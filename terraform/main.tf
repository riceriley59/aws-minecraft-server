provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "minecraft-vpc" {
  cidr_block           = "10.3.15.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft-vpc"
  }
}

resource "aws_subnet" "minecraft-subnet-public1" {
  vpc_id                  = aws_vpc.minecraft-vpc.id
  cidr_block              = "10.3.15.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "minecraft-subnet-public1"
  }
}

resource "aws_subnet" "minecraft-subnet-public2" {
  vpc_id                  = aws_vpc.minecraft-vpc.id
  cidr_block              = "10.3.15.16/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2b"

  tags = {
    Name = "minecraft-subnet-public2"
  }
}

resource "aws_internet_gateway" "minecraft-gw" {
  vpc_id = aws_vpc.minecraft-vpc.id

  tags = {
    Name = "minecraft-gw"
  }
}

resource "aws_route_table" "minecraft-rt-public" {
  vpc_id = aws_vpc.minecraft-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft-gw.id
  }

  tags = {
    Name = "minecraft-rt-public"
  }
}

resource "aws_route_table_association" "minecraft-public1" {
  subnet_id      = aws_subnet.minecraft-subnet-public1.id
  route_table_id = aws_route_table.minecraft-rt-public.id
}

resource "aws_route_table_association" "minecraft-public2" {
  subnet_id      = aws_subnet.minecraft-subnet-public2.id
  route_table_id = aws_route_table.minecraft-rt-public.id
}

resource "aws_security_group" "minecraft-sg" {
  name        = "minecraft-sg"
  description = "Allow SSH and Minecraft access"
  vpc_id      = aws_vpc.minecraft-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft-server" {
  ami           = "ami-075686beab831bb7f"
  instance_type = "t2.small"
  subnet_id     = aws_subnet.minecraft-subnet-public1.id
  key_name      = "M4 Macbook Pro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.minecraft-sg.id]

  tags = {
    Name = "Terraform Minecraft Server"
  }
}

