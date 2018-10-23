#!/bin/sh
set -x 
cat vc1023.csv | while read line; do
NAME=$(echo $line|awk -F, '{print $1}')
EMAIL=$(echo $line|awk -F, '{print $2}')
export NAME=$NAME
envsubst < trad.tmpl > body.html
mutt -x -F muttrc -s "启明医生（基于区块链的大病再问诊平台；种子已融，寻天使投资）" -H body.html -a "启明医生商业计划书.pdf"  -- $EMAIL </dev/null
done
