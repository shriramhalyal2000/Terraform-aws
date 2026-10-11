# Jenkins server with iac deployment and management.

- creating a high capaity ec2 capable of handling jenkins deployment loads.
- Server specs of t3.med 30GiB, Sg with 8080 ingress and allow http/s traffic on it.
- deploying this instance with terraform.
- ami - amz-lnx-ami
- storage ebs - 30 gib
- security group - allow http(80), ssh(20), custom (8080)
- region - us-east-1
- iam instance profile -ec2 read-only
- ssm login profile
- instance type - t3.med 
- terminate on deletion ebs

# Jenkins VPC
- a vpc with cidr 10.0.0.0/16
- a public subnet in us-east-1a
  - subnet cidr 10.0.1.0/24
- IGW, public RT association.