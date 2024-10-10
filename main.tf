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
  region  = "ap-south-1"
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtdBO0ah3t2UAONU9vXch6Hu89jY4p9p9oBJNuGCzcYSJwxK8ioxXCwm33A0zKM+RTIiZcvVu6g8sK+YQ358bLRn763jwKWT8Mmh+yau8nIDtcaT6cRaEmRn/ZtjUh73i6DoF6BpA/C1JBTw65UuUpSLizVMfAlx+7D4ZPNizxOapq9B86AF1+7HYVDU/9xKbEX4eFjz8YXdmdIcNcMrxswcEkFg54c+tXai6n/hHxXFgbIDGw9JMd/UAZpkVBOhp8oDTpNTKgaOj4VCmx7hynW4q55KnM2vYZGvg9iyDxz8DL48NefsaeYiihQllsCxT3furgaDcA9/ubcr2aYvEbemZ6vlcBuI4R92Dv7Pej/SrN/F5xxQSsXbsxlPqkNgz/0uaxr6Z3/7eZrNw5pnzJzDpZ3DWfcJjDzW15uDULDPH+1nRmqlymMh31i68RZGd7hnIxV23XCuNTSLZENUCOZ+JM5EgKWRrlYOrkvK2n3gEczOJ+SSbhxvfYz8sMx/qiD/tQZzXnAgn2/n1MGjAMGWNWP00uX+ncZqzxvHERAGf4ATVc9M8i1xlMGU0roiZOwayG5bWYaVtqxCtnkrng/GYQzKxBMKkej6xW+LPZoj0oiSlXFla6F2Cj/WXqdX6/QWV194L64zskyRiIdVpn3m87Qd5hkRLIbnw6ejJnuQ== ubuntu@ci-server"
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
