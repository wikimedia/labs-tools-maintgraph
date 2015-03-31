#!/bin/bash

# Senza interlink,Redirect,Disambigue,Interprogetto,Portale

dati=$(date +%Y%m%d -d "yesterday")

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page LEFT JOIN langlinks ON ll_from = page_id WHERE page_namespace = 0 AND page_is_redirect = 0 AND ll_from IS NULL" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 1 AND page_namespace = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page_props WHERE pp_propname = 'disambiguation'" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM templatelinks WHERE tl_namespace = 10 AND (tl_title = 'Interprogetto' OR tl_title = 'Ip')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM templatelinks WHERE tl_namespace = 10 AND (tl_title = 'Portale' OR tl_title = 'Portali')" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/utils.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": utils.sh [overlap]"
  else
    echo $dati >> public_html/data/utils.csv
fi
