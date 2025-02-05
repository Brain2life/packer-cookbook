packer {
  required_plugins {
    amazon = {
      version = "~> 1.3.4"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  profile       = "my-project-name"
  ami_name      = "ubuntu-with-kubectl-eksctl-awscli"
  instance_type = "t2.micro"
  region        = "us-east-1"
  
  vpc_id        = "<vpc_id>"       # Specify your VPC ID 
  subnet_id     = "<subnet_id>"    # Specify your Subnet ID

  associate_public_ip_address = true

  iam_instance_profile = "<instance_profile_name>"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # AWS Account ID of Canonical
  }
  ssh_username = "ubuntu"
}

build {
  name    = "ubuntu-host-with-kubectl-eksctl-awscli"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      # Wait for snap loading
      "sudo snap wait system seed.loaded",

      # Install aws cli
      "sudo snap install aws-cli --classic",

      # Install kubectl
      "sudo snap install kubectl --classic",

      # Install helm
      "sudo snap install helm --classic",

      # Install Docker
      "sudo snap install docker",
      "sudo addgroup --system docker",
      "sudo adduser $USER docker",
      "newgrp docker",
      "sudo snap disable docker",
      "sudo snap enable docker",

      # Install eksctl
      "ARCH=amd64",
      "PLATFORM=$(uname -s)_$ARCH",
      "curl -sLO \"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz\"",
      "tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz",
      "sudo mv /tmp/eksctl /usr/local/bin",

      # Download Karpenter Helm installation chart
      "mkdir -p $HOME/helm-charts",
      "helm pull oci://public.ecr.aws/karpenter/karpenter --version 1.2.1 --destination $HOME/helm-charts"
    ]
  }
}