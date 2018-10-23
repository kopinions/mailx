#!/bin/sh
set -x 
cat investors.csv | while read line; do
NAME=$(echo $line|awk -F, '{print $1}')
EMAIL=$(echo $line|awk -F, '{print $2}')
export NAME=$NAME
envsubst < trad.tmpl > body.html
#docker run -e LANG="zh_CN.UTF-8" -e LC_CTYPE="zh_CN.UTF-8" -v `pwd`:/data --rm mailx mailx -v -r "周远征 <ted@themedicalchain.com>" -s "$(echo -e "启明医生（基于区块链的大病再问诊平台；种子已融，寻天使投资）\nContent-Type: text/html")" -a "/data/启明医生商业计划书.pdf" -S smtp="smtps://smtp.mxhichina.com:465" -S editheaders=1  -S encoding='quoted-printable' -S smtp-auth=login -S smtp-auth-user="ted@themedicalchain.com" -S smtp-auth-password='Ynyl_2018' -S ttycharset='utf-8' -S sendcharsets='utf-8' -S ssl-verify=ignore  $EMAIL < /data/body.html
mutt -x -F muttrc -s "启明医生（基于区块链的大病再问诊平台；种子已融，寻天使投资）" -H body.html -a "启明医生商业计划书.pdf"  -- $EMAIL </dev/null
done
