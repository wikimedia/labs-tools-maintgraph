#!/bin/bash

# Principale,Discussione,Utente,Discussioni utente,Wikipedia,Discussioni Wikipedia,File,Discussioni file,MediaWiki,Discussioni MediaWiki,Template,Discussioni template,Aiuto,Discussioni aiuto,Categoria,Discussioni categoria,Portale,Discussioni portale,Progetto,Discussioni progetto,Modulo,Discussioni modulo

dati=$(date +%Y%m%d -d "yesterday")

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 1 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 2 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 3 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 4 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 5 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 6 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 7 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 8 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 9 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 10 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 11 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 12 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 13 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 14 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 15 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 100 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 101 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 102 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 103 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 828 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 829 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/pages.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": pages.sh [overlap]"
  else
    echo $dati >> public_html/data/pages.csv
fi
