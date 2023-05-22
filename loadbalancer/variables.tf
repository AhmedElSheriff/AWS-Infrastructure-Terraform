variable "lb_names" {
    type = list
    default = ["Public-Load-Balancer", "Private-Load-Balancer"]
}

variable "tg_names" {
    type = list
    default = ["Public-Target-Group", "Private-Target-Group"]
}

variable "listen_port" {
    type = number
    default = 80
}

variable "listen_protocol" {
    type = string
    default = "HTTP"
}

variable "pub_subnets" {
    type = list
}

variable "priv_subnets" {
    type = list
}

variable "http_ssh_sg" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_instances" {
    type = list
}

variable "private_instances" {
    type = list
}