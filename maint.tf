terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#AWS Provider 
provider "aws" {
  region = var.region
}

#Creation of the VPC ECF-vpc
resource "aws_vpc" "ecf_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "ecf-vpc"
  }
}

#Create 1st subnet named subnet_front in the previous VPC
resource "aws_subnet" "subnet_front" {
  vpc_id     = aws_vpc.ecf_vpc.id
  cidr_block = var.subnet_front_cidr_block
  availability_zone = var.az_front
  tags = {
    Name = "subnet_front"
  }
}


#Create 2nd subnet named subnet_back in the previous VPC
resource "aws_subnet" "subnet_back" {
  vpc_id     = aws_vpc.ecf_vpc
  cidr_block = var.subnet_back_cidr_block
  availability_zone = var.az_back
  tags = {
    Name = "subnet_back"
  }
}

#Associate route table to the subnet_front
resource "aws_route_table_association" "subnet_front_association" {
  subnet_id      = aws_subnet.subnet_front.id
  route_table_id = aws_route_table.studi_rt.id
}

#Associate route table to the subnet_back
resource "aws_route_table_association" "subnet_back_association" {
  subnet_id      = aws_subnet.subnet_back.id
  route_table_id = aws_route_table.studi_rt.id
}

#Create security group sgr_emr_master in the previous VPC 
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for my application"
  vpc_id      = "vpc-0f62caa1158f14445"

  // Règles entrantes
  // Par exemple, permettre le trafic SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Règles sortantes
  // Par exemple, permettre tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create the MongoDB Cluster with Document DB
  resource "aws_docdb_cluster" "docdb" {
    cluster_identifier = var.cluster_identifier
    engine = "docdb"
    engine_version = var.engine_version
    master_username = var.master_username
    master_password = var.master_password
    enabled_cloudwatch_logs_exports = ["audit", "profiler"]
}

#Create Instances in the previous Cluster 
resource "aws_docdb_cluster_instance" "docdb_instances" {
  count              = var.instance_count
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
  engine             = "docdb"
}

#Create Apache Spark Cluster using EC2
resource "aws_emr_cluster" "spark_cluster" {
  name          = var.cluster_name
  release_label = var.release_label 
  applications  = var.applications
  log_uri = "s3://${aws_s3_bucket.emr_logs.bucket}/logs/"

#Create EC2 in the previous subnet_back,with sgr, type of instance and ssh key par
  ec2_attributes {
    subnet_id                         = aws_subnet.subnet_back.id
    instance_profile                  = var.instance_profile
    emr_managed_master_security_group = aws_security_group.sgr_emr_master.id
    emr_managed_slave_security_group  = aws_security_group.sgr_emr_slave.id
    key_name = aws_key_pair.studi_key.key_name
  }

  service_role = var.service_role
  autoscaling_role = var.autoscaling_role


#Set the instance type and bumber of instances for the core instance group
  core_instance_group {
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count
  }
}

#Create the MongoDB Cluster with Document DB
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "docdb"
  engine_version          = var.engine_version
  master_username         = var.master_username
  master_password         = var.master_password
  skip_final_snapshot     = true
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]
}

#Create Instances in the previous Cluster 
resource "aws_docdb_cluster_instance" "docdb_instances" {
  count              = var.instance_count
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
  engine             = "docdb"
}