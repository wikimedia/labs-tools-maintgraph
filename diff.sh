#!/bin/bash

# data,tmp,A,cat,C,CC,corr,D,E,finz,L,org,O,rec,F,chiar,NN,CN,S,Ss,T,U,neut,senzau,W

# old data in file 1, new data in file 2

dati=$(date +%Y%m%d)

function swap()
{
    mv "$1" tmp
    mv "$2" "$1"
    mv tmp "$2"
}

# aggiungere_template

FILENAME="diffs/aggiungere_template"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Aggiungere_template%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# aiutare

FILENAME="diffs/aiutare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Aiutare%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# categorizzare

FILENAME="diffs/categorizzare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Categorizzare%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# controllare

FILENAME="diffs/controllare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Controllare%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# controllate_copyright

FILENAME="diffs/controllate_copyright"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Controllare_copyright%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# correggere

FILENAME="diffs/correggere"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Correggere%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# dividere

FILENAME="diffs/dividere"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Dividere%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# encicloped

FILENAME="diffs/encicloped"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Verificare_enciclopedicit%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# finzione

FILENAME="diffs/finzione"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Finzione_non_contestualizzata%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# localismo

FILENAME="diffs/localismo"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Localismo%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# organizzare

FILENAME="diffs/organizzare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Organizzare%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# orfane

FILENAME="diffs/orfane"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Pagine_orfane%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# recentismo

FILENAME="diffs/recentismo"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Recentismo%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# senza_fonti

FILENAME="diffs/senza_fonti"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Senza_fonti%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# chiarire

FILENAME="diffs/chiarire"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Chiarire%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# contestualizzare

FILENAME="diffs/contestualizzare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Contestualizzare_fonti%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# info_senza_fonte

FILENAME="diffs/info_senza_fonte"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Informazioni_senza_fonte%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# stub

FILENAME="diffs/stub"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Stub%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# stub_s

FILENAME="diffs/stub_s"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Stub_sezione%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# tradurre

FILENAME="diffs/tradurre"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Tradurre%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# unire

FILENAME="diffs/unire"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Unire%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# voci_non_neutrali

FILENAME="diffs/voci_non_neutrali"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Voci_non_neutrali%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# voci_senza_uscita

FILENAME="diffs/voci_senza_uscita"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Voci_senza_uscita%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

# wikificare

FILENAME="diffs/wikificare"

swap ${FILENAME}1.txt ${FILENAME}2.txt

mysql --defaults-file=replica.my.cnf -h itwiki.labsdb -e "SELECT page_title FROM page WHERE page_namespace = 0 AND page_id IN (SELECT cl_from FROM categorylinks WHERE cl_to LIKE 'Wikificare%') ORDER BY page_title" itwiki_p > ${FILENAME}2.txt

added=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep ">" | wc -l)
deleted=$(diff ${FILENAME}1.txt ${FILENAME}2.txt | grep "<" | wc -l)

dati+=",$added,$deleted"

echo $dati >> public_html/data/diff.csv
