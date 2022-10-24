terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = ">= 4.0"
  }
  backend "s3" {
    bucket = "admin-terraform-curso-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile                  = "default"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}


resource "aws_instance" "web3" {
  count                   = length(var.int_name)
  ami                     = var.amis[var.region]
  instance_type           = var.int_type
  disable_api_termination = var.disable_api_termination
  user_data               = file("./files/userdata.sh")

  tags = {
    Name = var.int_name[count.index]
    Environment : "dev"
  }
}
