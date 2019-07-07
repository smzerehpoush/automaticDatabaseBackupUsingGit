# automacticDatabaseBackupUsingGit
a script that automatically backups your mysql database and upload to your git repository<br/>
just clone the project<br/>
then run ./prerequisite.sh one time.<br/>
then ./fullBackup.sh<br/>

you can put it on crontan like this

    crontab -u USER -e
    @daily /path/to/fullBackup.sh > /dev/null 2>&1
