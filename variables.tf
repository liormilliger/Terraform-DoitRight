variable "AMI" {
  type        = string
  description = "Image for ubuntu instance"
}

variable "VPC_ID" {
  description = "ID of my vpc"
}

variable "HOME_IP" {
  description = "IP address at home"
  type        = string
}


variable "KARMI_IP" {
  description = "IP at KARMI house"
  type        = string
}

variable "SG" {
  type        = list(string)
  description = "SG for liorm-TF-easy instances"
}

variable "RT_ID" {
  description = "Route Table ID"
}

variable "SUBNET_1A" {
  description = "us-east-1a subnet"
}

variable "SUBNET_1B" {
  description = "us-east-1b subnet"
}

variable "TG_ARN" {
  description = "Target Group Amazon Resource Name (ARN)"
}