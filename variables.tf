variable "init" {
    type = object({
	env = string
	eks_name = string 
	eks_version = string
	vpc_cidr = string 
	newbits = number
	netnum = number
    })
    default = {
	env = "staging"
	eks_name = "c_quantum_toolkit"
	eks_version = "1.29"
	vpc_cidr = "172.16.10.0/24" 
	newbits = 2 # split into 2^n parts, here 4
	netnum = 4 # enumerate through those four parts
    }
}
