##########################################################
# EC2 instance for Jenkins server
##########################################################

# Call the external data source to get public IP
data "external" "my_ip" {
  program = ["bash", "./get_public_ip.sh"]
}

module "ec2-jenkins-server" {
  source  = "cloudposse/ec2-bastion-server/aws"
  version = "~> 0.31.1"

  name                        = "jenkins-server"
  associate_public_ip_address = true
  ssm_enabled                 = true
  ami                         = "ami-007f5292c6d029453" # Specify devsecops-image AMI

  subnets = module.vpc.public_subnets
  vpc_id  = module.vpc.vpc_id

  security_group_rules = [
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "-1"
      cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
    },
    {
      type        = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
    },
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}