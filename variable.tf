variable "vpc-cidr" {
    default = "10.0.0.0/16"
    description = "VPC CIDR BLOCK"
    type = string
}

variable "public-subnet-1-cidr" {
    default = "10.0.0.0/24"
    description = "PUBLIC SUBNET 1 CIDR BLOCK"
    type = string
}


variable "public-subnet-2-cidr" {
    default = "10.0.1.0/24"
    description = "PUBLIC SUBNET 2 CIDR BLOCK"
    type = string
}


variable "public-subnet-3-cidr" {
    default = "10.0.2.0/24"
    description = "PUBLIC SUBNET 3 CIDR BLOCK"
    type = string
}

variable "ssh-location" {
    default = "0.0.0.0/0"
    description = "IP Address to SSH into EC2 Instance"
    type = string
}

variable "domain_name" {
  default    = "dannyboy.live"
  type        = string
  description = "Domain name"
}
