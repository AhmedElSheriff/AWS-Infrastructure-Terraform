# IAC with Terraform

An AWS highly available and secure Infrastructure As Code utilizing Terraform consists of 1 VPC, 4 subnets, and 2 availability zones

## Workflow
The infrastructure comprises a Virtual Private Cloud (VPC) and an Internet gateway to enable Internet access for EC2 instances.
It encompasses two public and two private EC2 instances, along with one public and one private load balancer.
The public load balancer consists of a target group containing the two public EC2 instances which are configured with Nginx as a proxy to redirect traffic to the private load balancer.
The private load balancer, on the other hand, includes a target group comprising the two private EC2 instances with Apache installed.

## Infrastructure Diagram
![Infrastructure Diagram](https://raw.githubusercontent.com/AhmedElSheriff/AWS-Infrastructure-Terraform/master/infrastructure.jpeg)

## Modules
The terraform files are split into 5 modules other than the root files
1. The "vpc" module encompasses the primary network infrastructure, encompassing the VPC, subnets, internet gateway, and NAT gateways.
2. The "ec2" module encompasses the creation of the public and private AWS EC2 instances.
3. The "local_files" module includes script files utilized in the public Nginx servers and private Apache servers.
4. The "security_groups" module incorporates the security groups used in the public and private EC2 instances.
5. The "loadbalancer" module encapsulates the creation of the public and private load balancers, target groups, and listeners.

## Notes
For enhanced state management and coordination, the Terraform configuration is set to employ a remote backend utilizing an S3 bucket with versioning enabled to store multiple versions of the Terraform state file. Additionally, a DynamoDB table is utilized to control resource locking.