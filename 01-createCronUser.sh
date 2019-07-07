#!/bin/bash

#create a user for backing up data
mysql -u root -p << EOF 
CREATE USER if not exists 'cron_user'@'localhost' IDENTIFIED BY 'someStrongPassword';
GRANT SELECT,LOCK TABLES, EVENT, TRIGGER, SHOW VIEW  ON *.* TO 'cron_user'@'localhost';
FLUSH PRIVILEGES;
EOF
