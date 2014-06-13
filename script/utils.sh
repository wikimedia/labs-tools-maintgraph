#!/bin/bash

# Senza interlink,Redirect,Disambigue,Interprogetto

dati=$(date +%Y%m%d)

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page LEFT JOIN langlinks ON ll_from = page_id WHERE page_namespace = 0 AND page_is_redirect = 0 AND ll_from IS NULL" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 1 AND page_namespace = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM templatelinks WHERE tl_namespace = 10 AND (tl_title = 'Disambigua' OR tl_title = 'Sigla2' OR tl_title = 'Sigla3')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM templatelinks WHERE tl_namespace = 10 AND (tl_title = 'Interprogetto' OR tl_title = 'Ip')" itwiki_p | tail -1)
dati+=",$dato"

echo $dati >> ../public_html/data/utils.csv
