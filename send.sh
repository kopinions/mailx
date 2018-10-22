#!/bin/sh
set -x 
cat test.csv | while read line; do
NAME=$(echo $line|awk -F, '{print $1}')
EMAIL=$(echo $line|awk -F, '{print $2}')
export NAME=$NAME
envsubst < trad.tmpl > body
docker run -v `pwd`:/data --rm mailx mailx -v -r "neo <neo@themedicalchain.com>" -s "启明医生（基于区块链的大病再问诊平台；种子已融，寻天使投资）" -a /data/商业计划书.pdf -S smtp="smtps://smtp.mxhichina.com:465" -S smtp-auth=login -S smtp-auth-user="neo@themedicalchain.com" -S smtp-auth-password='password' -S ttycharset='utf-8' -S sendcharsets='utf-8' -S ssl-verify=ignore -q /data/body $EMAIL 
done
