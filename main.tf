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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZEgKiXrDFqomCGzXf3t3DBtR+Tz3IaulesOKSMLPAckq6eSx2whhBw7zW8tXuceN5caRz3cMyNX/EygWNwAXtmTV3w41YwPicMUdqF6RE+HS+9UriJZbStBnLNqMkVnsGHpndmgsDza1dIqBkRm5Q1WZuZ/7gHEqVyQtnetdoifsZ3EtHEKVGj4gKqdiCNwoiXsyLB7oI0l+7QvCNYe+0PgqsUkay63ylrvRYxsKyWUUWT89KC5GN4d20WwHpxWpB1GRf4N2KCZmIwB2uaoQ5fIRjHnh16GTGYrPPk1togxxoWJ26UFw9sytSoixd65axRgWm81zhQwCnSXQI061s3t1NfboNyKFBpUYIsZ8RHfxvsfP5PwBzWLY5crSbiQSluKTGHiwEd3RHMWTIkiD4Nu9rIqYpPjwuUb+UumLOGfrjHXi4QMbr7kOtIdoj7eaKYSy6umR/3DYlvZBzMuxwzPIFkLEMavOyS3fikHknxPNEJbC85bZN66Z4G9M0qPOrdUK4KEtIRSS8pQ94gPR27Vo4lsAnAcqdY+KnxNtVcexwRkj4aB/3g3kYQPs+KqQqxW4qpumtMuZ5azvGmkh+95lRgopsoYysJLaPTiTq/4paqaheihHo0P+ICsxIu4VsSvlCESKz+yJpNd5fb6uYscu8CDJf2ojQ6RcebMzwfQ== jenkins@ci-server"
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
