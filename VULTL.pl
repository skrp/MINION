#!/usr/local/bin/bash
# requires https://github.com/skrp/MKRX
#######################################
# VULTL - vulture to archive data bones
# -------------------------skrp of MKRX
scrape () {
sub="$1"
XS "dump/" ".";
|| printf "%s failed\n" "$sub" >> VULTL_log;
}
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
  mv "$path_to_minion"/"$line >> dump/"$i";
done 
} 
sub="$i"
scrape "$sub";
}
