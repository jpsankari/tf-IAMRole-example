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
  value = module.vpc.ec2_web_name
}

output "s3_name" {
  value = module.vpc.bucket_name
  #modele.vpc is my module name module/vpc
}

//IAM Role & Policy

locals {
 name_prefix = "sankari"
}


resource "aws_iam_role" "role_example" {
 name = "${local.name_prefix}-role-example"

 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Sid    = ""
       Principal = {
         Service = "ec2.amazonaws.com"
       }
     },
   ]
 })
}

resource "aws_iam_policy" "policy_example" {
 name = "${local.name_prefix}-policy-example"


 ## Option 1: Attach data block policy document
 policy = data.aws_iam_policy_document.policy_example.json


}


resource "aws_iam_role_policy_attachment" "attach_example" {
 role       = aws_iam_role.role_example.name
 policy_arn = aws_iam_policy.policy_example.arn
}


resource "aws_iam_instance_profile" "profile_example" {
 name = "${local.name_prefix}-profile-example"
 role = aws_iam_role.role_example.name
}
