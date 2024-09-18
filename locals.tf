locals {
    region = "eu-central-1"
    zone1 = "eu-central-1a"
    zone2 = "eu-central-1b"
    newbits = var.init.newbits # divide into 2^n subnets 
    netnum = var.init.netnum # in general number of subnets
    subnets_list = [for i in range(local.netnum) : cidrsubnet(var.init.vpc_cidr, local.newbits, i)]
}
