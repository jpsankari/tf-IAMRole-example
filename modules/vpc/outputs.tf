output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main-vpc.id
}

output "subnet1_id" {
  description = "The ID of the first subnet"
  value       = aws_subnet.subnet1_public.id
}

output "subnet2_id" {
  description = "The ID of the second subnet"
  value       = aws_subnet.subnet2_private.id
}

output "sg_sankari_ssh_id" {
  description = "The ID of the security group"
  value = aws_security_group.sg_sankari_ssh.id
}

//print EC2 Name
output "ec2_bestine_name" {
  description = "The name of the bestine server"
  value = aws_instance.bestine_server.tags["Name"]
}

//print EC2 Name
output "ec2_web_name" {
    description = "The name of the web server"
  value = aws_instance.web_server.tags["Name"]
}