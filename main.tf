provider "aws" {
  region = "us-east-1"
  profile = "dev"
}

# Initialize Remote Backend
resource "aws_s3_bucket" "bucket" {
    bucket = var.s3_name
    object_lock_enabled = true
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

resource "aws_s3_bucket_versioning" "s3_ver" {
    bucket = aws_s3_bucket.bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_object_lock_configuration" "s3_lock" {
    bucket = aws_s3_bucket.bucket.id
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = var.dynamodb_table_name
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-iti"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}


module "vpc" {
    source = "./vpc"
}

module "security_groups" {
    source = "./security_groups"
    vpc_id = module.vpc.vpc_id
}

module "local_files" {
    source = "./local_files"
    private_lb_dns = module.loadbalancer.private_lb_dns
}

module "ec2" {
    source = "./ec2"
    vpc_id = module.vpc.vpc_id
    priv_subnets = module.vpc.priv_subnets
    pub_subnets = module.vpc.pub_subnets
    allow_http_ssh = module.security_groups.allow_http_ssh
    apache2 = module.local_files.apache2
    nginx_proxy = module.local_files.nginx_proxy
}

module "loadbalancer" {
    source = "./loadbalancer"
    priv_subnets = module.vpc.priv_subnets
    pub_subnets = module.vpc.pub_subnets
    http_ssh_sg = module.security_groups.allow_http_ssh
    vpc_id = module.vpc.vpc_id
    public_instances = module.ec2.public_instance_ids
    private_instances = module.ec2.private_instance_ids
}