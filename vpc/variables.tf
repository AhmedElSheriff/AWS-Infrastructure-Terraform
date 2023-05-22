variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnets_cidr" {
    type = map
    default = {
        pub_subs = ["10.0.0.0/24", "10.0.2.0/24"],
        priv_subs = ["10.0.1.0/24", "10.0.3.0/24"]
    }
}

variable "availability_zones" {
    type = list
    default = ["us-east-1a", "us-east-1b"]
}