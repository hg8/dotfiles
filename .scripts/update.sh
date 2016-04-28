#!/bin/sh
#Hugo

#Count how many update available using checkupdate

#echo "$(checkupdates|wc -l)+$(cower -u|wc -l)"|bc -l
COUNTARCH=$(checkupdates|wc -l)
COUNTAUR=$(cower -u|wc -l)

TOTAL=$(($COUNTARCH+$COUNTAUR))

if [[ $TOTAL -ge 1 ]]; then
	echo " "$TOTAL
fi

if [[ "${BLOCK_BUTTON}" -eq 1 ]]; then
	urxvt -e pacaur -Syu ; 
fi
