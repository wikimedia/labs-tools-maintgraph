#!/bin/bash

cd /data/project/maintgraph

./statistiche.sh

./diff.sh

tail -n 1 public_html/stats/statistiche.csv > bot.csv
