variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.3.15.0/24"
}

variable "subnet_cidr_public1" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.3.15.0/28"
}

variable "subnet_cidr_public2" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.3.15.16/28"
}

variable "availability_zone_1" {
  description = "Availability zone for subnet 1"
  type        = string
  default     = "us-west-2a"
}

variable "availability_zone_2" {
  description = "Availability zone for subnet 2"
  type        = string
  default     = "us-west-2b"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-075686beab831bb7f"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "minecraft-server-ansible"
}

variable "key_path" {
  description = "SSH key pair path"
  type        = string
}

