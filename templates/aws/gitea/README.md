# AMI for Gitea on EC2 instance

![](https://i.imgur.com/0KSOnvb.png)

This project shows how to provision pre-configured EC2 AMI with Gitea tool installed.  
In short, [Gitea](https://docs.gitea.com/) is a self-hosted open-source Git service. It is similar to GitHub, Bitbucket and GitLab.

Official Github repository: [github.com/go-gitea/gitea](https://github.com/go-gitea/gitea)

## Overview
AMI is provisioned with Gitea version 1.23.6. For more information, see [Installation from binary](https://docs.gitea.com/installation/install-from-binary).

After installation, Gitea is [run as a Linux service](https://docs.gitea.com/installation/linux-service) via systemd.
In the following piece of code:
```bash
"echo 'After=network.target mariadb.service' | sudo tee -a /etc/systemd/system/gitea.service",
```
Gitea expects local MariaDB service to be in running state. If your DB instance is not on the same EC2 host, then change this line to:
```bash
"echo 'After=network.target' | sudo tee -a /etc/systemd/system/gitea.service",
```

For storing repository, configuration data, Gitea needs a Database. You can run database on the same instance, or use separate services
like AWS RDS. 

Access Gitea at `http://<ec2_public_domain_or_ip>:3000` and configure it via Web UI:

![](https://i.imgur.com/K6Nnhnd.png)

**NOTE**  
Don't forget to allow **inbound rule on port 3000** for EC2 instance security group.

To add SSL/TLS support for Gitea, use [certbot](https://certbot.eff.org/) or [letsencrypt](https://letsencrypt.org/) with [reverse proxy](https://docs.gitea.com/administration/reverse-proxies). For more information,
see [HTTPS Setup](https://docs.gitea.com/administration/https-setup). 

## References
- [Example of Gitea systemd service v1.22](https://github.com/go-gitea/gitea/blob/release/v1.22/contrib/systemd/gitea.service)
