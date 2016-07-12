#!/bin/bash
cd /var/www/

#basic backup of the var/www directory to a mounted network drive
tar zcf /media/backup/Backup/Computers/Sites/webserver-`date +%Y%m%d`.tar.gz html

