#!/bin/bash

cd /data/project/maintgraph

# lavoro_sporco.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat public_html/data/lavoro_sporco.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo ": lavoro_sporco.sh [skip]"
  else
    if [ $(date +%H) -eq 19 ]
      then
        echo ": lavoro_sporco.sh [run]"
      else
        echo ": lavoro_sporco.sh [failover]"
    fi

    ./lavoro_sporco.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/lavoro_sporco.csv | grep -E "[0-9]{8},([0-9]+,){23}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": lavoro_sporco.sh [ok]"
        tail -n 1 public_html/data/lavoro_sporco.csv > bot.csv
      else
        echo ": lavoro_sporco.sh [error]"
        echo -e "Subject: lavoro_sporco.sh [error]\n\nChecking of lavoro_sporco.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
    fi
fi

# diff.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat ./public_html/data/diff.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo ": diff.sh [skip]"
  else
    if [ $(date +%H) -eq 19 ]
      then
        echo ": diff.sh [run]"
      else
        echo ": diff.sh [failover]"
    fi

    ./diff.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/diff.csv | grep -E "[0-9]{8},([0-9]+,){47}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": diff.sh [ok]"
      else
        echo ": diff.sh [error]"
        echo -e "Subject: diff.sh [error]\n\nChecking of diff.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
    fi
fi

# pages.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat ./public_html/data/pages.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo ": pages.sh [skip]"
  else
    if [ $(date +%H) -eq 19 ]
      then
        echo ": pages.sh [run]"
      else
        echo ": pages.sh [failover]"
    fi

    ./pages.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/pages.csv | grep -E "[0-9]{8},([0-9]+,){21}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": pages.sh [ok]"
      else
        echo ": pages.sh [error]"
        echo -e "Subject: pages.sh [error]\n\nChecking of pages.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
    fi
fi

# edits.sh
echo -n $(date "+%Y-%m-%d %H:%M:%S")
cat ./public_html/data/edits.csv | grep $(date +%Y%m%d) > /dev/null

if [ $? -eq 0 ]
  then
    echo ": edits.sh [skip]"
  else
    if [ $(date +%H) -eq 19 ]
      then
        echo ": edits.sh [run]"
      else
        echo ": edits.sh [failover]"
    fi

    ./edits.sh

    echo -n $(date "+%Y-%m-%d %H:%M:%S")
    tail -n 1 public_html/data/edits.csv | grep -E "[0-9]{8},([0-9]+,){3}[0-9]+" > /dev/null

    if [ $? -eq 0 ]
      then
        echo ": edits.sh [ok]"
      else
        echo ": edits.sh [error]"
        echo -e "Subject: edits.sh [error]\n\nChecking of edits.csv failed." | /usr/sbin/exim -odf -i  maintgraph.maintainers@tools.wmflabs.org
    fi
fi
