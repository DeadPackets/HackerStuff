#!/bin/bash

##Simple bash script to check if a site is really down.

SITE=$1
echo '----------------------------------------'
echo '| DDos Checker by shadowblade7536 v1.0 |'
echo '----------------------------------------'
echo ''
curl --silent isup.me/$SITE| sed -e 's/<[^>]*>//g' | grep $SITE | sed 's/......//' |  sed 's/[\#;:&-]//g' | sed 's/httpx2Fx2F//g'
echo ''
