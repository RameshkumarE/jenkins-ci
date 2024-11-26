terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1a"
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC26KJwGqhIWI2cgnqjK55QVHXd6ZRE4ISBBvuYC2L6tarek2qB9AeoDiPhv5aNzctcYo9inpScbXoDwL3uVTiwdyKqZbfe2229YfEzt7uOTe0EQlW+mwlZaZk8kBO2GFkmd2DC6Horj6SyBwmvHy0kn1x4pKKuahWyqhz2fLvCmaWQrQKq/BdokJHE+L2TrKTgHTwK8x8Lk9EBrcsi5vAYnzb4aGQ2GGUvhNBfJyamQTyNaBNvwd+amo38wXRhOPCXenCJBmmifMx63+upi0dNs4ZMb/haVgfdXwzBwpyunLFD0MM7wiCr2p6OmLoWtClLDD+Nhlr0QkSZDEv3PGtUQ5vYnx6RqdTQGW6U0FQONfIdqJ1WLPi67ecKO9ihvebm9g1/C0mYVUd2rmsxiYcgLd89JImBjNrFNA41pUo8uq3gU3wtfVhGx5/zbOF+uywPAfNgXeESNvTeghXR+O7SV7/Dj9N7+oUDUhlqfhZw+UW5nscUl7BE/0G3BdjDxLGR5eryrGrythWTA9YgeTgsLRQxSy8rzByD8bBa3WO+X9o1eRAsWghRl+X2b7K5fLP3lSGcDdFpNNFb/DuklBntAWiwDbSBTeFyI/ckyVO8CQGUb2U+zvy5zJToBg4d8xlPVJKbjeVzEy/OSi2UnOI+zlphqxXZVmB7neIVIVs1tQ== jenkins@ci-server"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins-key.key_name
  tags = {
    Name = "webserver"
  }
}

output "ec2_ip" {
  value = "${aws_instance.example_server.public_ip}"
}
