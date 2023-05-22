# IAC with Terraform

An AWS highly available and secure Infrastructure As Code built with Terraform consists of 1 VPC, 4 subnets, and 2 availability zones

## Workflow
The infrastructure has a VPC and an Internet gateway to give the EC2 instances an internet access.
It also includes 2 public and 2 private EC2 instances as well as 1 public and 1 private load balancers.
The public load balancer has a target group consists of the 2 public EC2 instances with Nginx on them configured as a proxy to redirect traffic to the private load balancer.
The private load balancer has a target group consists of the 2 private EC2 instances with Apache installed on them

## Infrastructure Diagram
![Infrastructure Diagram](https://github.com/AhmedElSheriff/AWS-Infrastructure-Terraform/infrastructure.jpeg)

## Modules
The terraform files are split into 5 modules other than the root files
* The `vpc` module includes the main network infrastructure, such as VPC, Subnets, Internet Gateway, and NAT Gateways
* The `ec2` module includes the public and private AWS EC2 instances
* The `local_files` module, includes that script files used in the public Nginx servers, and the private Apache servers
* The `security_groups` module, includes the security groups used in the public and private EC2 instances
* The `loadbalancer` module, includes the public and private load balancers, target groups, and listeners

## Notes
The terraform is configured to use a remote backend using an S3 bucket and a DynamoDB on AWS