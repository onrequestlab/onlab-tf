#####################################
## AWS Provider Module - Variables ##
#####################################

# AWS connection & authentication

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "instance_names" {
  default = {
    "master" = "1"
    "nodea"  = "2"
    "nodeb"  = "3"
    "nodec"  = "4"
  }
}