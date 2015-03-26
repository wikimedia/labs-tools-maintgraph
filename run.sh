#!/bin/bash

cd /data/project/maintgraph

# clean log
if [ $(wc -c < log.txt) -ge 1048576 ]
  then
    rm log.txt
fi

# lavoro_sporco.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/lavoro_sporco.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": lavoro_sporco.sh [skip]"
  else
    echo ": lavoro_sporco.sh [run]"

    ./script/lavoro_sporco.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/lavoro_sporco.csv | grep -E "[0-9]{8},([0-9]+,){23}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": lavoro_sporco.sh [ok]"
        tail -n 1 public_html/data/lavoro_sporco.csv > bot.csv
      else
        echo ": lavoro_sporco.sh [error]"
        echo -e "Subject: lavoro_sporco.sh [error]\n\nChecking of lavoro_sporco.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/lavoro_sporco.csv
    fi
fi

# diff.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/diff.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": diff.sh [skip]"
  else
    echo ": diff.sh [run]"

    ./script/diff.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/diff.csv | grep -E "[0-9]{8},([0-9]+,){47}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": diff.sh [ok]"
      else
        echo ": diff.sh [error]"
        echo -e "Subject: diff.sh [error]\n\nChecking of diff.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/diff.csv
    fi
fi

# pages.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/pages.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": pages.sh [skip]"
  else
    echo ": pages.sh [run]"

    ./script/pages.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/pages.csv | grep -E "[0-9]{8},([0-9]+,){21}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": pages.sh [ok]"
      else
        echo ": pages.sh [error]"
        echo -e "Subject: pages.sh [error]\n\nChecking of pages.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/pages.csv
    fi
fi

# edits.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/edits.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": edits.sh [skip]"
  else
    echo ": edits.sh [run]"

    ./script/edits.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/edits.csv | grep -E "[0-9]{8},([0-9]+,){4}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": edits.sh [ok]"
      else
        echo ": edits.sh [error]"
        echo -e "Subject: edits.sh [error]\n\nChecking of edits.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/edits.csv
    fi
fi

# utils.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/utils.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": utils.sh [skip]"
  else
    echo ": utils.sh [run]"

    ./script/utils.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/utils.csv | grep -E "[0-9]{8},([0-9]+,){4}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": utils.sh [ok]"
      else
        echo ": utils.sh [error]"
        echo -e "Subject: utils.sh [error]\n\nChecking of utils.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/utils.csv
    fi
fi

# lengths.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/lengths.csv | grep $(date +%Y%m%d -d "yesterday") > /dev/null

if [ $? -eq 0 ]
  then
    echo ": lengths.sh [skip]"
  else
    echo ": lengths.sh [run]"

    ./script/lengths.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/lengths.csv | grep -E "[0-9]{8},([0-9]+,){10}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": lengths.sh [ok]"
      else
        echo ": lengths.sh [error]"
        echo -e "Subject: lengths.sh [error]\n\nChecking of lengths.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
        sed -i '$ d' public_html/data/lengths.csv
    fi
fi
