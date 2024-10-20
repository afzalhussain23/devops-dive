# Automated MongoDB Backups to Cloudflare R2 🚀

This guide will help you set up automated MongoDB backups to Cloudflare R2 using an AWS EC2 instance.

## Prerequisites

- AWS account (Free tier eligible)
- Cloudflare account with R2 enabled

## Setup Instructions 🛠️

### 1. Create EC2 Instance

Create a t2.micro EC2 instance on AWS (Free tier eligible).

### 2. Install MongoDB 🍃

Install MongoDB on the instance using the official guide:
[MongoDB Installation Guide for Amazon Linux](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-amazon/)

### 3. Set Up Cloudflare R2 🪣

Create a bucket on Cloudflare R2.

### 4. Configure AWS Credentials

1. Manually edit the AWS credentials file:
   ```
   nano ~/.aws/credentials
   ```

2. Create a new profile for your R2 bucket (e.g., "r2") and add the following:
   ```
   [r2]
   aws_access_key_id = <your_access_key_id>
   aws_secret_access_key = <your_secret_access_key>
   region = <your_region>
   endpoint_url = https://<accountid>.r2.cloudflarestorage.com
   ```

### 5. Set Up Cron Job

1. Open the crontab file:
   ```
   crontab -e
   ```

2. Add the following line to run the script every 12 hours:
   ```
   0 */12 * * * /path/to/backup_and_upload.sh
   ```

Part of this DevOps project: https://roadmap.sh/projects/automated-backups