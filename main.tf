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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.int_type
  disable_api_termination = var.disable_api_termination
  tags = {
    Name = var.int_name[0]
    Environment : "dev"
  }
}

resource "aws_instance" "web2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.int_type
  disable_api_termination = var.disable_api_termination
  tags = {
    Name = var.int_name[1]
    Environment : "dev"
  }
}
/*instancia importada da aws usando o terraform import*/
resource "aws_instance" "web3" {
  ami                     = var.amis[var.region]
  instance_type           = var.int_type
  disable_api_termination = var.disable_api_termination
  tags = {
    Name = var.int_name[2]
    Environment : "dev"
  }
}
