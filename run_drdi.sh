#!/bin/bash

cd /data/project/maintgraph

# clean log
if [ $(wc -c < log_drdi.txt) -ge 1048576 ]
  then
    rm log_drdi.txt
fi

# drdi.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/drdi.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo ": drdi.sh [skip]"
  else
    echo ": drdi.sh [run]"

    ./script/drdi.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/drdi.csv | grep -E "[0-9]{8},([0-9]+,){4}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": drdi.sh [ok]"
      else
        echo ": drdi.sh [error]"
#        echo -e "Subject: drdi.sh [error]\n\nChecking of drdi.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/drdi.csv
    fi
fi
