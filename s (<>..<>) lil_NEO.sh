#!/usr/local/bin/bash
################### SUMMONS #
# NEO - scrape searchcode.com
#   (<>..<>) --- skrp of MKRX
# BEGIN #####################
init=$( cat init )
base="http://searchcode.com/codesearch/raw/";
while [ $init -lt 127100000 ]
do
	((init++));
	fetch $base$init || printf "%s fail\n" "$init" >> log;
	echo $init > init;
	printf  "%s done\n" "$init";
done

