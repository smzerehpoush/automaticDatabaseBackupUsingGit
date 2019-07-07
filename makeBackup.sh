#!/bin/bash
# Set variables
DB_NAME="testHibernate"
CRON_USER="cron_user"
CRON_PASS="someStrongPassword"
FULLDATE=$(date +"%Y-%d-%m %H:%M")
NOW=$(date +"%Y-%m-%d-%H-%M")
MYSQL_DUMP=`which mysqldump`
GIT=`which git`
TEMP_BACKUP="latest_backup.sql"
GIT_REPOSITORY_DIR="myDbBackup"
BACKUP_DIR=$(date +"%Y/%m")

cd "$GIT_REPOSITORY_DIR"
# Check current Git status and update
${GIT} status
${GIT} pull origin HEAD

touch "$TEMP_BACKUP"

# Dump database
${MYSQL_DUMP} -u "$CRON_USER" -p"$CRON_PASS"  $DB_NAME > $TEMP_BACKUP &
wait

# Make backup directory if not exists (format: {year}/{month}/)
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p $BACKUP_DIR
fi

# Compress SQL dump
tar -cvzf $BACKUP_DIR/$DB_NAME-$NOW-sql.tar.gz $TEMP_BACKUP

# Remove original SQL dump
#rm -f $TEMP_BACKUP

# Add to Git and commit
${GIT} add -A
${GIT} commit -m "Automatic backup - $FULLDATE"
${GIT} push origin HEAD
