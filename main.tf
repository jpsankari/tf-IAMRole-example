module "vpc" {
  source = "./modules/vpc"  
  cidr_block = "10.0.0.0/16"
  subnet1_cidr_public = "10.0.1.0/24"
  subnet2_cidr_private = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet1_id" {
    value = module.vpc.subnet1_id
}

output "subnet2_id" {
  value = module.vpc.subnet2_id
}

output "ssh_sg_id" {
  value = module.vpc.sg_sankari_ssh_id
}

//print EC2 Name
output "ec2_bestine" {
  value = module.vpc.ec2_bestine_name
}

//print EC2 Name
output "ec2_web" {
  value = module.vpc.ec2_bestine_name
}