#!/bin/bash

# Edit totali,Edit minori,Edit IP,Edit oscurati,Edit bot

dati=$(date +%Y%m%d -d "yesterday")

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM revision WHERE rev_minor_edit <> -1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM revision WHERE rev_minor_edit = 1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM revision WHERE rev_actor IN (SELECT actor_id FROM actor WHERE actor_user IS NULL)" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM revision WHERE rev_deleted = 1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM revision WHERE rev_actor IN (SELECT actor_user FROM user_groups, actor WHERE ug_user = actor_user AND ug_group = 'bot')" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/edits.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": edits.sh [overlap]"
  else
    echo $dati >> public_html/data/edits.csv
fi
