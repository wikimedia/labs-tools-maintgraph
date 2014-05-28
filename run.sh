#!/bin/bash

cd /data/project/maintgraph

./lavoro_sporco.sh

./diff.sh

tail -n 1 public_html/data/lavoro_sporco.csv > bot.csv
