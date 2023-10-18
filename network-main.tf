# ##########################################
# ## Network Single AZ Public Only - Main ##
# ##########################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
    filter {
    name   = "availability-zone"
    values = ["ap-south-1a"]
  }
}

