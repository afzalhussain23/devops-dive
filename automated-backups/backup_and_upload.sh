#!/bin/bash

# Set variables
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/home/backup/mongodb"
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
R2_BUCKET="mongodb-backups"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform MongoDB backup
mongodump --out $BACKUP_DIR/temp_backup

# Create tarball of the backup
tar -czf $BACKUP_DIR/$BACKUP_FILE -C $BACKUP_DIR temp_backup

# Remove temporary backup directory
rm -rf $BACKUP_DIR/temp_backup

# Upload to Cloudflare R2
aws s3 cp --profile r2 $BACKUP_DIR/$BACKUP_FILE s3://$R2_BUCKET/ --endpoint-url https://<accountid>.r2.cloudflarestorage.com

# Remove local backup file
rm $BACKUP_DIR/$BACKUP_FILE

# Log the backup completion
echo "Backup completed and uploaded to R2: $BACKUP_FILE" >> /var/log/mongodb_backups.log