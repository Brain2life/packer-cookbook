packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  region      = "us-east-1"
  source_ami  = "ami-08b5b3a93ed654d19" # Amazon Linux 2023
  instance_type = "t2.micro"
  ssh_username = "ec2-user"
  ami_name    = "amazon-linux-2023-lamp-{{isotime \"2006-01-02-150405\"}}"
}

build {
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "shell" {
    inline = [
      # Update software packages
      "sudo dnf upgrade -y",

      # Install the latest versions of Apache web server and PHP packages
      "sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel",

      # Install the MariaDB software packages and all related dependencies at the same time.
      "sudo dnf install mariadb105-server -y",

      # Add ec2-user to the apache group
      "sudo usermod -a -G apache ec2-user",

      # Change the group ownership of /var/www and its contents to the apache group
      "sudo chown -R ec2-user:apache /var/www",

      # To add group write permissions and to set the group ID on future subdirectories
      "sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \\;",

      # To add group write permissions, recursively change the file permissions of /var/www and its subdirectories
      "find /var/www -type f -exec sudo chmod 0664 {} \\;",

      # Enable the Apache web server
      "sudo systemctl enable httpd"
    ]
  }
}
