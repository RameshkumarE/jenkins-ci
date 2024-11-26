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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC07qjXZG6s9FOKbMFXpBBwDpilE16KNBg5JDYoBH/hx1WVvt/D0L3BfbDxzuuAgreOH2nsAKhCjtuFUuJ/PAGyMSZFf8dAk6m915jCysx9VphQszqiIRy1PE/8lqUA+Tb/YumFZLQia90vLUgmx4RSBTf9zpQLhl8DadIanpVtLOKFBmD9fXI4h3pdNMcKgfMt4nU3GemPQsBhHnjyCWJiofbOakkVG5wDUR1Az8kf/xoCR8fAV17w3kJZGCA3FavhZ44P2unLSKWqIHJ5sqTMCIIR+MQAVFmQHckH+lYCObOOlz5VJcQjYcg7LufdEO9oLNYUy4/0w+Ihxs1x8aQQ0TkqSy7PdkSf0eZpOTCMaSm6Ip1Ip1n0HgLImeN1hHE8rTgUl9bpBNd/pXr5DBBwwD9LrOCSPHKuwIp1wD8YflIQ7+ArB7Q0A3m+1uAIKsm6alo48PMB9o4v+HhX3HCxhn8/El3hV3BE+Be0QzOUf+JW5TDrY3IRyrnJ/VpWDGOQtdAepH13s9u3pxbac67JypcV9HSuYD6kvXCyDYEr1D2rDIqt0AD4P5yS8gSl7YrdyQi1NEp0i7mpR5U5MzWtjcP1t60PmNhH1ySFYgShl65bzviFFem4y9IMLnhpO+JdeRAEKR2Wp5XFbxzXEm70CUSZl+z5VhzNEQ+UTqOPdQ== ubuntu@ip-172-31-95-191"
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
