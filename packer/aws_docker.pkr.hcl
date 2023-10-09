# aws_docker.pkr.hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

#pass your source

source "amazon-ebs" "ubuntu" {
  ami_name      = "docker-packer-ubuntu-ami-2"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-053b0d53c279acc90"
    #most_recent = true
    #owners      = ["909614386406"]
  ssh_username = "packer"
}

build {
  name = "docker-test-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    script = "./ansible.sh"
  }
  provisioner "ansible-local" {
    playbook_file = "./docker.yml"
  }
}