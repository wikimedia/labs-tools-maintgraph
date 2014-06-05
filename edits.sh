#!/bin/bash

# Edit totali,Edit minori,Edit di IP,Edit revertati

dati=$(date +%Y%m%d)

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_minor_edit = 1" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_user = 0" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM revision WHERE rev_deleted = 1" itwiki_p | tail -1)
dati+=",$dato"

echo $dati >> public_html/data/edits.csv
