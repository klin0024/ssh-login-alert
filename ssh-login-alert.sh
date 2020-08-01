#!/usr/bin/env bash
 
USERID=( "< USERID >" ) #ex: -384689483
KEY="< KEY >" #ex: 792925382:AAFA5DWI-sWyRuOb_KFViAKg4mlJwgmGB5I

getText(){
cat <<EOF
*Date: ${DATE}*
Connection From: *${CLIENT_IP}*
Connection User: *${USER}*
Connection Host: *${SRV_HOSTNAME}* (*${SRV_IP}*)
EOF
}

for i in "${USERID[@]}"
do
URL="https://api.telegram.org/bot${KEY}/sendMessage"
DATE="$(date "+%Y/%m/%d %H:%M")"

if [ -n "$SSH_CLIENT" ]; then
	CLIENT_IP=$(echo $SSH_CLIENT | awk '{print $1}')

	SRV_HOSTNAME=$(hostname -f)
	SRV_IP=$(hostname -I | awk '{print $1}')

	cat TEXT=$(getText)

	curl -s -k -d "chat_id=$i&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown" $URL > /dev/null 2>&1 &
fi
done
