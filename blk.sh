#!/bin/sh
set -x 
cat blk1023.csv | while read -r line ||  [ -n "$line" ]; do
NAME=$(echo $line|awk -F, '{print $1}')
EMAIL=$(echo $line|awk -F, '{print $2}')
export NAME=$NAME
envsubst < blk.tmpl > blk_body.html
mutt -x -F muttrc -s "好医链（基于区块链技术的医疗价值生态系统；种子已融，寻天使投资）" -H blk_body.html -a "好医链商业计划书.pdf"  -- $EMAIL </dev/null
done
