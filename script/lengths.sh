#!/bin/bash

# 0-750,750-1500,1500-3000,3000-6000,6000-12500,12500-25000,25000-50000,50000-75000,75000-100000,100000-125000,125000-inf

dati=$(date +%Y%m%d)

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len < 750" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 750 AND page_len < 1500" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 1500 AND page_len < 3000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 3000 AND page_len < 6000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 6000 AND page_len < 12500" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 12500 AND page_len < 25000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 25000 AND page_len < 50000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 50000 AND page_len < 75000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 75000 AND page_len < 100000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 100000 AND page_len < 125000" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_is_redirect = 0 AND page_namespace = 0 AND page_len >= 125000" itwiki_p | tail -1)
dati+=",$dato"

echo $dati >> public_html/data/lengths.csv
