#!/usr/local/bin/bash
# requires https://github.com/skrp/MKRX
#######################################
# VULTL - vulture to archive data bones
#       >++('>        -----skrp of MKRX
path_to_minion="$1"
# FUNCTIONS ###########################
list () {
index=0
while read -r line
do
  TASKLIST[$index]=$line;
	((index++));
done < VULTL_target # list minions
rm VULT_target;
}
task () {
path_to_minion=${1%/}
for i in "${TASKLIST[@]}"
do
  readlink -f "$path_to_minion"/"$i"/dump/* >> VULTL_init;
done
}
trans () {
while read -r line
do
  minion=${line%/}
  mv "$minion" dump/;
done < VULT_init
rm VULT_init;
} 
# ACTION  #######################
while true
do
	if [ -f VULTL_target ] 
	then
		list;
		task "$path_to_minion";
		sleep 43200;
		trans;
		d=$( date +%d%m_%H%M%S )
		XS "dump/" "." || printf "%s failed\n" "$d" >> VULTL_log;
		# pool/ & g/ are the final dump dirs
	else
		sleep 3600;
	fi
done
