variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  region     = "us-east-2"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "project-key" {
  key_name   = "project-key"
  public_key = "ssh-rsa AAAAB3N punnareddy.local"
}

resource "aws_instance" "web2" {
  ami           = "ami-11aa8c74"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.project-key.key_name}"

  tags {
    Name = "Web App"
  }
}

output "instance_ips" {
  value = "${aws_instance.web2.public_ip}"
}
