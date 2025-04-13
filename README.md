# packer-cookbook

![](./img/packer_logo.jpeg)

## What is Packer?

[Packer](https://developer.hashicorp.com/packer/install) is a community tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel. Packer does not replace configuration management like Chef or Puppet. In fact, when building images, Packer is able to use tools like Chef or Puppet to install software onto the image.

A *machine image* is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include [AMIs for EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html), VMDK/VMX files for VMware, OVF exports for VirtualBox, etc.

## How to build a machine image?

The basic workflow to build the machine image is:
1. Change current directory to the required template folder with `<filename>.pkr.hcl` configuration file.
2. Initialize the project and download required plugins:
```bash
packer init .
```
3. Build the image:
```bash
packer build <filename>.pkr.hcl 
```

## Templates
- [AWS AMI for Bastion host with pre-installed tools to communicate and work with EKS cluster](./templates/aws/bastion-host-to-eks/)
- [AWS AMI for LAMP stack based on AL2023](./templates/aws/al2023-lamp-stack/)
- [AWS AMI for Gitea self-hosted Git service](./templates/aws/gitea/)
- [AWS AMI for Jenkins server with Trivy and SonarQube](./templates/aws/jenkins-trivy-sonarqube/)