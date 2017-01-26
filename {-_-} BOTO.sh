#!/usr/local/bin/bash
###############################
# BOTO - website mirror scraper
#   {-_-}       ---skrp of MKRX
# FUNCTION ####################
scrape () {
sub="$1"
wget --wait=1 -e robots=off --no-check-certificate --mirror --continue $sub \
|| printf "%s failed\n" "$sub" >> BOTO_log;
}
init () {
index=0
while read -r line
do
	TASKLIST[$index]=$line;
	((index++));
done < BOTO_target 
rm BOTO_target;
}
task () {
for i in "${TASKLIST[@]}"
do
	sub="$i"
	scrape "$sub";
done
}
# ACTION  #######################
while true
do
	if [ -f BOTO_target ] 
	then
		init;
		task;
	else
		sleep 1000;
	fi
done

