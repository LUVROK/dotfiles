#!/bin/sh

# get current connection status
CONTROL_CHAR='\x02'
CONSTATE=$(nmcli -fields CONNECTIVITY g)
if [[ "$CONSTATE" =~ "none" || "$CONSTATE" =~ "limited" ]]; then
	WIFISTATE=$(nmcli -fields WIFI g)
	if [[ "$WIFISTATE" =~ "disabled" ]]; then
		STATUS="󰤮"
	else
		STATUS="󰤫"
	fi
elif [[ "$CONSTATE" =~ "full" ]]; then
	STATUS=$(
		nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $9, $10}}' |
			awk '{print ($1 ~ /▂|▄|▆|█/ ? $1 : $2)}' |
			sed "s/▂▄▆█/󰤨/g" |
			sed "s/▂▄▆_/󰤥/g" |
			sed "s/▂▄__/󰤢/g" |
			sed "s/▂___/󰤟/g"
	)
fi
echo -e "${STATUS}"