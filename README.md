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
- [AWS AMI based on Ubuntu 22.04 with pre-installed aws, kubectl and eksctl CLI tools](./templates/aws/ubuntu-kubectl-eksctl-awscli/)