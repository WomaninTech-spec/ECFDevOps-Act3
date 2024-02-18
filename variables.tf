variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "subnet_id" {
  description = "Subnet ID for the EMR cluster"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC ECF"
  type = string
  default     = "172.31.0.0/16"
}

variable "emr_managed_master_security_group" {
  description = "Security group ID for the master node"
  type        = string
}

variable "subnet_front_cidr_block" {
  description = "The CIDR block for the subnet_front"
  type = string
  default     = "172.31.0.0/20"
}

variable "az_front" {
  description = "AZ For subnet front"
  type = string
  default = "eu-central-1a"  
}

variable "subnet_back_cidr_block" {
  description = "The CIDR block for the subnet_back"
  type        = string
  default     = "172.31.16.0/20"
}

variable "az_back" {
  description = "AZ For subnet back"
  type = string
  default = "eu-central-1b"  
}

variable "emr_managed_slave_security_group" {
  description = "Security group ID for the slave nodes"
  type        = string
}

variable "core_instance_type" {
  description = "EC2 instance type for the core nodes"
  type        = string
  default     = "m5.xlarge"
}

variable "core_instance_count" {
  description = "Number of EC2 instances for the core nodes"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "The EC2 key pair name for SSH access to the EMR instances"
  type        = string
}

variable "service_role" {
  description = "The IAM role for the EMR service"
  type        = string
  default     = "EMR_DefaultRole"
}

variable "autoscaling_role" {
  description = "The IAM role for EMR autoscaling"
  type        = string
  default     = "EMR_AutoScaling_DefaultRole"
}

variable "instance_profile" {
  description = "The instance profile for EMR EC2 instances"
  type        = string
  default     = "EMR_EC2_DefaultRole"
}

variable "cluster_name" {
  description = "The name of the EMR cluster"
  type        = string
}

variable "release_label" {
  description = "The release label for the EMR software"
  type        = string
}

variable "applications" {
  description = "List of applications to install on the cluster"
  type        = list(string)
}

variable "cluster_identifier" {
  description = "The identifier for the DocumentDB cluster."
  type        = string
}

variable "engine_version" {
  description = "The engine version for the DocumentDB cluster."
  type        = string
  default     = "5.0.0"
}

variable "master_username" {
  description = "The master username for the DocumentDB cluster."
  type        = string
}

variable "master_password" {
  description = "The master password for the DocumentDB cluster."
  type        = string
}

variable "instance_count" {
  description = "The number of instances in the DocumentDB cluster."
  type        = number
  default     = 3
}

variable "instance_class" {
  description = "The instance class to use for the DocumentDB cluster."
  type        = string
  default     = "db.t3.medium"
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [22]  
}
