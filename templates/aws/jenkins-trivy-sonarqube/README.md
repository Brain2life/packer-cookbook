# DevSecOps AMI image for Jenkins

This project shows how to Provision Jenkins CI/CD with the security scanning tools installed. The following components are provisioned in AMI:
- [Jenkins LTS version](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)
- [Trivy scanner](https://trivy.dev/v0.18.3/installation/)

## Jenkins configuration

Jenkins server accessible on port `8080`:

![](https://i.imgur.com/dNQZoRn.png)

Customize Jenkins with additional security plugins such as SonarQube:

![](https://i.imgur.com/YcqsQzP.png)

For more information, see [SonarQube Jenkins plugin](https://plugins.jenkins.io/sonar/)

## References
- [HashiForum: How to disable interactive dialogs in Packer](https://discuss.hashicorp.com/t/how-to-fix-debconf-unable-to-initialize-frontend-dialog-error/39201)
