# Install S3 Mountpoint Client

**Mountpoint for Amazon S3** is a free and fast tool that lets you use an **Amazon S3 bucket like a local folder** on your computer. With it, your apps can open and read files in S3 just like they would from a regular hard drive.

Behind the scenes, Mountpoint turns these file actions (like “open” or “read”) into S3 API requests, so your app gets the **speed and scalability of S3**, while still working with files in a familiar way.

For more information, see [Installing Mountpoint](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mountpoint-installation.html#mountpoint.install.deb)

The given packer file creates AMI with S3 Mountpoint Client installed and signature verified.

During the build process you should see the client version and signature verification lines:
```bash

---
    amazon-ebs.s3mount: mount-s3 1.18.0

---
==> amazon-ebs.s3mount: gpg: Signature made Fri May 30 14:00:39 2025 UTC
==> amazon-ebs.s3mount: gpg:                using RSA key BE397A52B086DA5A
==> amazon-ebs.s3mount: gpg: Good signature from "Mountpoint for Amazon S3 <mountpoint-s3@amazon.com>" [unknown]
...
