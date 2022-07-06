variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}
variable "name" {
  type        = string
  default     = "ifs-dev"
}

variable "private_subnets"{
  type = list(string)
  default     = ["10.0.1.0/24", "10.1.1.0/24"]
}

variable "public_subnets"{
  type = list(string)
  default     = ["10.0.0.0/24", "10.1.0.0/24"]
}