#!/usr/local/bin/bash
# requires https://github.com/skrp/MKRX
#######################################
# VULTL - vulture to archive data bones
# -------------------------skrp of MKRX
# FUNCTIONS ###########################
list () {
index=0
while read -r line
do
  TASKLIST[$index]=$line;
	((index++));
done < VULTL_target # list minions
}
task () {
path_to_minion=${1%/}
for i in "${TASKLIST[@]}"
do
  ls "$path_to_minion"/"$i" >> VULTL_init;
done
}
trans () {
while read -r line
do
  mv "$path_to_minion"/"$line" dump/"$line";
done < VULT_init
rm VULT_init;
} 
path_to_minion="$1"
# ACTION  #######################
while true
do
	if [ -f BOTO_target ] 
	then
		list;
		task "$path_to_minion";
		trans;
		sleep 43200;
		d=$( date +%d%m_%H%M%S )
		XS "dump/" "." || printf "%s failed\n" "$d" >> VULTL_log;
	else
		sleep 1000;
	fi
done
