provider "aws" {
  region = var.region
}

resource "aws_vpc" "minecraft-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft-vpc"
  }
}

resource "aws_subnet" "minecraft-subnet-public1" {
  vpc_id                  = aws_vpc.minecraft-vpc.id
  cidr_block              = var.subnet_cidr_public1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "minecraft-subnet-public1"
  }
}

resource "aws_subnet" "minecraft-subnet-public2" {
  vpc_id                  = aws_vpc.minecraft-vpc.id
  cidr_block              = var.subnet_cidr_public2
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2

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

resource "aws_key_pair" "minecraft-key" {
  key_name   = var.key_name
  public_key = file(var.key_path)
}

resource "aws_instance" "minecraft-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.minecraft-subnet-public1.id
  key_name      = aws_key_pair.minecraft-key.key_name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.minecraft-sg.id]

  tags = {
    Name = "Terraform Minecraft Server"
  }
}
