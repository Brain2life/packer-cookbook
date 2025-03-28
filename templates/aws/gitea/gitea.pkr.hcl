packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "gitea" {
  region        = "us-east-1"
  source_ami    = "ami-0a25f237e97fa2b5e" # Ubuntu 20.04 LTS in us-east-1 region
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "gitea"
}

build {
  sources = ["source.amazon-ebs.gitea"]

  provisioner "shell" {
    inline = [
      # Update software packages
      "sudo apt-get update -y",

      # Install & Configure Gitea
      "echo 'Installing Gitea...'",
      "sudo mkdir -p /var/lib/gitea",
      "sudo useradd --system --home /var/lib/gitea --shell /bin/bash gitea",
      "sudo wget -O /usr/local/bin/gitea https://dl.gitea.com/gitea/1.23.6/gitea-1.23.6-linux-amd64",
      "sudo chmod +x /usr/local/bin/gitea",

      # Create Configuration & Data Directories
      "echo 'Configuring Gitea data directories...'",
      "sudo mkdir -p /etc/gitea /var/lib/gitea/{custom,data,log}",
      "sudo chown -R gitea:gitea /var/lib/gitea /etc/gitea",
      "sudo chmod -R 750 /var/lib/gitea /etc/gitea",
      "sudo touch /etc/gitea/app.ini",
      "sudo chmod 640 /etc/gitea/app.ini",
      "sudo chown -R gitea:gitea /etc/gitea",
      "sudo chmod 640 /etc/gitea/app.ini",

      # Create and configure Gitea systemd service
      "echo 'Creating Gitea systemd service...'",
      "echo '[Unit]' | sudo tee /etc/systemd/system/gitea.service",
      "echo 'Description=Gitea Self-Hosted Git Server' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'After=network.target mariadb.service' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo '' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo '[Service]' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'User=gitea' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'Group=gitea' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'Restart=always' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'WorkingDirectory=/var/lib/gitea' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'Environment=USER=gitea HOME=/var/lib/gitea' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo '' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo '[Install]' | sudo tee -a /etc/systemd/system/gitea.service",
      "echo 'WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/gitea.service",

      # Enable Gitea systemd service
      "echo 'Reloading systemd and enabling Gitea service...'",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable --now gitea"
    ]
  }
}