#!/bin/bash

# Link a disambigua,Link a redirect di disambigua,Link blu totali,Disambigue,Voci

dati=$(date +%Y%m%d)

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM pagelinks WHERE pl_namespace = 0 AND pl_title IN (SELECT page_title FROM page, page_props WHERE page_id = pp_page AND pp_propname = 'disambiguation') AND pl_from IN (SELECT page_id FROM page WHERE page_namespace = 0 AND page_is_redirect = 0)" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM pagelinks WHERE pl_namespace = 0 AND pl_title IN (SELECT page_title FROM pagelinks, page WHERE pl_namespace = 0 AND page_id = pl_from AND pl_title IN (SELECT page_title FROM page, page_props WHERE page_id = pp_page AND pp_propname = 'disambiguation') AND pl_from NOT IN (SELECT page_id FROM page WHERE page_namespace <> 0 OR page_is_redirect = 0)) AND pl_from NOT IN (SELECT page_id FROM page WHERE page_namespace <> 0 OR page_is_redirect = 1)" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM pagelinks WHERE pl_namespace = 0 AND pl_title IN (SELECT page_title FROM page WHERE page_namespace = 0) AND pl_from NOT IN (SELECT page_id FROM page WHERE page_namespace <> 0 OR page_is_redirect = 1)" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM page_props WHERE pp_propname = 'disambiguation'" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h itwiki.analytics.db.svc.eqiad.wmflabs -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_is_redirect = 0" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/drdi.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": drdi.sh [overlap]"
  else
    echo $dati >> public_html/data/drdi.csv
fi
