#!/bin/bash
cd /var/www/html

#specifically backup the dokuwiki website
tar zcf /media/backup/Backup/Computers/Sites/dokuwiki-`date +%Y%m%d`.tar.gz dokuwiki

