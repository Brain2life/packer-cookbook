packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "devsecops" {
  region        = "us-east-1"
  source_ami    = "ami-0a25f237e97fa2b5e" # Ubuntu 20.04 LTS in us-east-1 region
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "devsecops-image"
}

build {
  sources = ["source.amazon-ebs.devsecops"]

  provisioner "shell" {
    inline = [
      # Update software packages
      "sudo apt-get update -y",

      # Disable interactive dialogs
      "echo set debconf to Noninteractive", 
      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",

      # Install Java
      "sudo apt install -y fontconfig openjdk-17-jre",

      # Install Jenkins LTS
      "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key",
      "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install -y jenkins",

      # Enable Jenkins
      "sudo systemctl enable jenkins",

      # Install Trivy
      "sudo apt-get install -y wget apt-transport-https gnupg lsb-release",
      "wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -",
      "echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list",
      "sudo apt-get update -y",
      "sudo apt-get install -y trivy"
    ]
  }
}