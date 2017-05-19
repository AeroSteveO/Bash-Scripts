#!/bin/bash
# Performs a basic backup of files off of a Linux server
# Setup includes adding paths for what to backup, where to backup, and what to name it
# Resultant tar files of the directories are labeled with the current date of the backup
backupDir=/media/backup/
toBackup=/var/www/
name=Web-backup

cd $toBackup

#basic backup of the var/www directory to a mounted network drive
tar zcf $backupDir-`date +%Y%m%d`.tar.gz $name

