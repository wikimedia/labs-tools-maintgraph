#!/bin/bash

# data,tmp,A,cat,C,CC,corr,D,E,finz,L,org,O,rec,F,chiar,NN,CN,S,Ss,T,U,neut,senzau,W

dati=$(date +%Y%m%d -d "yesterday")

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Aggiungere_template%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Aiutare%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Categorizzare_-%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Controllare%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Controllare_copyright%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Correggere%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Dividere%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Verificare_enciclopedicit%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Finzione_non_contestualizzata%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Localismo%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Organizzare%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Pagine_orfane%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Recentismo%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Senza_fonti%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Chiarire%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Contestualizzare_fonti%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Informazioni_senza_fonte%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Stub%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Stub_sezione%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Tradurre%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Unire%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Voci_non_neutrali%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Voci_senza_uscita%')" itwiki_p | tail -1)
dati+=",$dato"

dato=$(mysql --defaults-file=replica.my.cnf -h s2.labsdb -e "SELECT COUNT(*) FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Wikificare%')" itwiki_p | tail -1)
dati+=",$dato"

cat public_html/data/lavoro_sporco.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    echo ": lavoro_sporco.sh [overlap]"
  else
    echo $dati >> public_html/data/lavoro_sporco.csv
fi
