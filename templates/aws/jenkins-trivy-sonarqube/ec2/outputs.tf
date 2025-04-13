output "server_id" {
  description = "EC2 instance ID of the server"
  value       = module.ec2-jenkins-server.instance_id
}

output "server_public_ip" {
  description = "Public IP address of server"
  value       = module.ec2-jenkins-server.public_ip
}

output "server_public_dns" {
  description = "Public DNS name of the server"
  value       = module.ec2-jenkins-server.public_dns
}