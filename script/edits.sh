#!/bin/bash

# Edit totali,Edit minori,Edit IP,Edit oscurati,Edit bot

dati=$(date +%Y%m%d -d "yesterday")

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_minor_edit = 1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_user = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_deleted = 1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_user IN (SELECT ug_user FROM user_groups WHERE ug_group = 'bot')" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/edits.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": edits.sh [overlap]"
  else
    echo $dati >> public_html/data/edits.csv
fi
