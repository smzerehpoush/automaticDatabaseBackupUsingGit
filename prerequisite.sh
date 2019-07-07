#!/bin/bash
CRON_USE="cron_user"
CRON_PASS="someStrongPassword"
GIT_REPO_URL="https://github.com/smzerehpoush/myDbBackup.git"
GIT_REPO_DIR="myDbBackup"

#create a user for backing up data
mysql -u root -p << EOF
CREATE USER if not exists '"$CRON_USER"'@'localhost' IDENTIFIED BY '"$CRON_PASS"';
GRANT SELECT,LOCK TABLES, EVENT, TRIGGER, SHOW VIEW  ON *.* TO '"$CRON_USER"'@'localhost';
FLUSH PRIVILEGES;
EOF

#clone git repo if not exists
if [ ! -d "$GIT_REPO_DIR" ] ; then
    git clone "$GIT_REPO_URL" "$GIT_REPO_DIR"
fi
