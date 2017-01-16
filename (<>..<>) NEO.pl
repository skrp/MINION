#!/usr/local/bin/perl
use strict; use warnings;
use File::Find::Rule;
use WWW::Mechanize;
#############################
# NEO - scrape searchcode.com
#   (<>..<>)  ---skry of MKRX
# USER AGENT ################
my ($dump) = @ARGV; $dump =~ s%/\z%%;
die "not a dump dir" unless -d $dump;
# SET UP ####################
my $base = "https://searchcode.com/codesearch/raw/";
my $init = "init";
open(my $ifh, '<', $init) or die "Couldn't read $init\n";
my $point = readline $ifh; chomp $point; close $ifh;
# LOOP ######################
while ($point < 127100000) {
	$point++;
	print "$point  started\n";
	my $url = "$base$point";
	my $mech = WWW::Mechanize->new();
	$mech->get($url);
	$mech->save_content("$dump/$point");
	print "$point  ended\n";
# ACCOUNTING ################
	if ($point % 10 == 0) {
		open(my $fifh, '>', $init);
		print $fifh "$point\n"; close $fifh;
	}
}
