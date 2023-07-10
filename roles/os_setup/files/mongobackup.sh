#!/bin/bash

# Configuration
BACKUP_PATH="/data/backup"
MONGO_CONTAINER_NAME="devopstesttask-app-mongo_production-1"
MONGO_DB_NAME="course-goals"
MONGO_USER="root"
MONGO_PASSWORD="example"
BACKUP_NAME="backup_`date +%Y_%m_%d_%H_%M_%S`"

# Create the backup directory if it does not exist
docker exec $MONGO_CONTAINER_NAME mkdir -p $BACKUP_PATH

# Create backup
echo "Create backup..."
docker exec $MONGO_CONTAINER_NAME mongodump --db=$MONGO_DB_NAME -u=$MONGO_USER -p=$MONGO_PASSWORD --authenticationDatabase=admin --archive=$BACKUP_PATH/$BACKUP_NAME
echo "Creation backup complited!"

# Delete old backups over 7 days old
docker exec $MONGO_CONTAINER_NAME find $BACKUP_PATH -type f -mtime +7 -exec rm -f {} \;