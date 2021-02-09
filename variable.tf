variable "azs" {
  description = "availability zones"
  type = list(string)
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "azs_cidr" {
  description = "CIDR BLOCK FOR SUBNET"
  type = list(string)
  default = ["192.168.2.0/24","192.168.3.0/24","192.168.4.0/24"]
}
variable "vpc-cidr"{}
variable "vpc-name" {}
variable "public-jumpserver" {}
variable "my-region" {}

variable "Myimages" {
  default = {
      us-east-1 = "ami-0885b1f6bd170450c",
      us-east-2 = "ami-0a91cd140a1fc148a",
      us-west-1 = "ami-00831fc7c1e3ddc60"
    }
}