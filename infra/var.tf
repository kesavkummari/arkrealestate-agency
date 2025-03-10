variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e386fa0b67b8b12c" # Change this to a valid AMI ID
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "digitaladdds-wordpress"
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instance"
  type        = list(any)
  default     = ["sg-010d6dd8270554a09"]
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
  default     = "subnet-0ab7ef12823c1b8c3"
}

variable "instance_name" {
  description = "Tag Name for the EC2 instance"
  type        = string
  default     = "ArkRealEstate"
}

variable "createdby" {
  default = "IaC-Terraform"
}