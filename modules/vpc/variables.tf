variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet1_cidr_public" {
  description = "The CIDR block for the first subnet"
  type        = string
}

variable "subnet2_cidr_private" {
  description = "The CIDR block for the second subnet"
  type        = string
}

variable "availability_zone" {
  description = "The Availability Zone for the subnets"
  type        = string
}

variable "sg_sankari_ssh" {
  description = "Optional SSH security group ID to use"
  type        = string
  default     = null
}