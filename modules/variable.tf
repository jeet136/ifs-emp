variable "availability_zone" {
  type    = list(string)
  default = []
}

variable "subnets" {
  description = ""
  type        = map(any)
  default     = {}
}

variable "vpcs" {
  description = ""
  type        = map(any)
  default     = {}
}

variable "routetables" {
  description = "Subnet route"
  type        = map(any)
  default     = {}
}

variable "nat_gateways" {
  description = ""
  type        = map(any)
  default     = {}
}

variable "IGW_gateways" {
  description = ""
  type        = map(any)
  default     = {}
}

variable "routetable_associations" {
  description = ""
  type        = map(any)
  default     = {}
}

variable "vpc_cidr" {
  type        = string
}

variable "name" {
  type        = string
}

variable "private_subnets"{
  type = list(string)
}

variable "public_subnets"{
  type = list(string)
}
