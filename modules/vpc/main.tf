resource "aws_vpc" "main-vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "ce10_sankari-main-vpc"
  }
}

resource "aws_subnet" "subnet1_public" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.subnet1_cidr_public
  availability_zone = var.availability_zone
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2_private" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.subnet2_cidr_private
  availability_zone = var.availability_zone
  tags = {
    Name = "subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1_public.id
  route_table_id = aws_route_table.route_table.id
}

#resource "aws_route_table_association" "subnet2_association" {
 # subnet_id      = aws_subnet.subnet2_private.id
  #route_table_id = aws_route_table.route_table.id
#}

resource "aws_security_group" "sg_sankari_ssh" {
  name        = "SG_sankari_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # ingress {
  #  description = "Allow HTTP"
   # from_port   = 80
    #to_port     = 80
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
    tags = {
    Name = "sg_sankari_ssh"
  }
}
resource "aws_instance" "bestine_server" {
  ami                    = "ami-0afc7fe9be84307e4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1_public.id
  vpc_security_group_ids = [aws_security_group.sg_sankari_ssh.id]
  key_name               = "sankariKP"
  associate_public_ip_address = true

  tags = {
    Name = "sankari bestine_server EC2"
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0afc7fe9be84307e4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet2_private.id
  vpc_security_group_ids = [aws_security_group.sg_sankari_ssh.id]
  associate_public_ip_address = false
  key_name               = "sankariKP"
  tags = {
    Name = "sankari web_server EC2"
  }
}

//s3 bucket creation
resource "aws_s3_bucket" "sankari_bucket" {
  bucket = "sankari-s3"        # Must be globally unique
  force_destroy = true
}
