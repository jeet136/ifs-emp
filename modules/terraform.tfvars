############  Multiple VPC Create with Subnet #################

vpcs = {
  vpc1 = {
    name                 = "vpc1-Jitesh"
    vpc_cidr             = "10.0.0.0/16"
    instance_tenacy      = "default"
    aws_internet_gateway = false
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
      Name        = "vpc1-Jitesh"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "Engage"
    }
  },
  vpc2 = {
    name                 = "vpc2-Jitesh"
    vpc_cidr             = "10.1.0.0/16"
    aws_internet_gateway = true
    instance_tenacy      = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
      Name        = "vpc2-Jitesh"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "Nest"
    }
  }
}

subnets = {
  subnet1 = {
    name                    = "vpc1-subnet-2"
    availability_zone       = "us-east-2a"
    cidr_block              = "10.0.1.0/24"
    vpc_key                 = "vpc1"
    public_subnet           = false
    map_public_ip_on_launch = false
    tags = {
      Name        = "vpc1-subnet-2"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "engage"
    }
  },
  subnet2 = {
    name                    = "vpc2-subnet-2"
    availability_zone       = "us-east-2a"
    cidr_block              = "10.1.1.0/24"
    public_subnet           = false
    vpc_key                 = "vpc2"
    map_public_ip_on_launch = false
    tags = {
      Name        = "vpc2-subnet-2"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "Nest"
    }
  },
  subnet3 = {
    name                    = "vpc1-subnet-1"
    availability_zone       = "us-east-2a"
    cidr_block              = "10.0.0.0/24"
    public_subnet           = true
    vpc_key                 = "vpc1"
    map_public_ip_on_launch = true
    tags = {
      Name        = "vpc1-subnet-1"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "engage"
    }
  },
  subnet4 = {
    name                    = "vpc2-subnet-1"
    availability_zone       = "us-east-2a"
    cidr_block              = "10.1.0.0/24"
    public_subnet           = true
    vpc_key                 = "vpc2"
    map_public_ip_on_launch = true
    tags = {
      Name        = "vpc2-subnet-1"
      Department  = "IT"
      Cost_Center = "3000"
      Application = "Nest"
    }
  }
}

routetables = {
  routetable1 = {
    vpc_key        = "vpc1"
    public         = true
    routetable_key = ""
    tags = {
      Name = "routetable_1"
    }
  },
  routetable2 = {
    vpc_key        = "vpc1"
    public         = false
    routetable_key = "natgateway1"
    tags = {
      Name = "routetable_2"
    }
  },
  routetable3 = {
    vpc_key        = "vpc2"
    public         = true
    routetable_key = ""
    tags = {
      Name = "routetable_3"
    }
  },
  routetable4 = {
    vpc_key        = "vpc2"
    public         = false
    routetable_key = "natgateway2"
    tags = {
      Name = "routetable_4"
    }
  }
}


nat_gateways = {
  natgateway1 = {
    subnet_key        = "subnet1"
    connectivity_type = "public"
    tags = {
      Name = "natgateway_1"
    }
    eip_tags = {
      Name = "eip1"
    }
  },
  natgateway2 = {
    subnet_key        = "subnet2"
    connectivity_type = "public"
    tags = {
      Name = "natgateway_2"
    }
    eip_tags = {
      Name = "eip2"
    }
  }
}

routetable_associations = {
  RT-assoc1 = {
    routetable_key = "routetable1"
    subnet_key     = "subnet3"
  },
  RT-assoc2 = {
    routetable_key = "routetable2"
    subnet_key     = "subnet1"
  },
  RT-assoc3 = {
    routetable_key = "routetable3"
    subnet_key     = "subnet4"
  },
  RT-assoc4 = {
    routetable_key = "routetable4"
    subnet_key     = "subnet2"
  }
}
