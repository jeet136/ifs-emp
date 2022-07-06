###### Create the VPC 
resource "aws_vpc" "Main" {
  for_each         = var.vpcs
  cidr_block       = each.value[var.vpc_cidr] # Creating VPC here
  instance_tenancy = each.value["instance_tenacy"]
  tags = {
    Name = each.value[var.name]
  }
}
######Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  for_each = var.vpcs
  vpc_id   = try(aws_vpc.Main[each.key].id, null) # vpc_id will be generated after we create VPC  
  tags = {
    Name = each.value["name"]
  }
}
######Create a Public Subnets.
resource "aws_subnet" "subnet" { # Creating Public Subnets
  for_each   = var.subnets
  vpc_id     = try(aws_vpc.Main[each.value.vpc_key].id, null)
  cidr_block = each.value.cidr_block # CIDR block of public subnets
  tags = {
    Name = each.value["name"]
  }
}
######Route table for Public Subnet's
resource "aws_route_table" "publicRoutetable" { # Creating RT for Public Subnet
  for_each = { for k, v in var.routetables : k => v if v.public == true }
  vpc_id   = try(aws_vpc.Main[each.value.vpc_key].id, null)
  tags     = each.value.tags
  dynamic "route" {
    for_each = each.value.public == true ? [1] : [0]
    content {
      cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
      gateway_id = try(aws_internet_gateway.IGW[each.value.vpc_key].id, null)
    }
  }
}

resource "aws_route_table" "privateRoutetable" { # Creating RT for Public Subnet
  for_each = { for k, v in var.routetables : k => v if v.public == false }
  vpc_id   = try(aws_vpc.Main[each.value.vpc_key].id, null)
  tags     = each.value.tags
  dynamic "route" {
    for_each = each.value.public == false ? [1] : [0]
    content {
      cidr_block     = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
      nat_gateway_id = try(aws_nat_gateway.NATgw[each.value.routetable_key].id, null)
    }
  }
}
######Route table Association with Public Subnet's
resource "aws_route_table_association" "PublicRTassociation" {
  for_each = var.routetable_associations
  #gateway_id     = try(aws_internet_gateway.IGW[each.value.gateway_key].id, null)
  subnet_id      = try(aws_subnet.subnet[each.value.subnet_key].id, null)
  route_table_id = try(aws_route_table.publicRoutetable[each.value.routetable_key].id, try(aws_route_table.privateRoutetable[each.value.routetable_key].id, null))

}
resource "aws_eip" "nateIP" {
  for_each          = var.nat_gateways
  vpc               = true
  network_interface = null
  tags              = each.value.eip_tags
}
######Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "NATgw" {
  for_each          = var.nat_gateways
  allocation_id     = try(aws_eip.nateIP[each.key].id, null)
  subnet_id         = try(aws_subnet.subnet[each.value.subnet_key].id, null)
  connectivity_type = each.value.connectivity_type
  tags              = each.value.tags
}