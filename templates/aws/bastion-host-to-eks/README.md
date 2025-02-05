## Ubuntu 22.04 with installed kubectl, eksctl and awscli

The given template creates AMI based on Ubuntu 22.04 machine with pre-installed `kubectl`, `eksctl`, `aws` and other essential CLI tools and files.
Created AMI can be used to provision AWS EC2 bastion host in a private subnet to communicate with EKS cluster. 

The following versions are installed:
- Latest classic version of `kubectl` from [Snap repository](https://snapcraft.io/kubectl)
- Latest classic version of `aws` from [Snap repository](https://snapcraft.io/aws-cli) 
- Latest version of `eksctl` from the official [Github repository](https://github.com/eksctl-io/eksctl/releases)
- Latest version of `docker` [Docker installation](https://docs.docker.com/engine/install/ubuntu/)
- Downloads Helm Chart for Karpenter 1.2.1 

**NOTE**  
All the tools installed in home directory of the `ubuntu`

If you are using SSM to connect to the bastion host, to switch to `ubuntu` user type:
```bash
sudo su ubuntu
```


