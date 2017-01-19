#!/usr/local/bin/perl
use strict; use warnings; $|=1; $0='NEO';
use File::Find::Rule;
use WWW::Mechanize;
use Proc::Daemon;
use LWP::UserAgent;
#############################
# NEO - scrape searchcode.com
#   (<>..<>)  ---skry of MKRX
# USER AGENT ################
my ($dump) = @ARGV; $dump =~ s%/\z%%;
die "not a dump dir" unless -d $dump;
# SET UP ####################
my $base = "https://searchcode.com/codesearch/raw/";
my $init = "init"; my $log = "log";
open(my $ifh, '<', $init) or die "Couldn't read $init\n";
open(my $lfh, '>>', $log) or die "Couldn't read $log\n";
my $point = readline $ifh; chomp $point; close $ifh;
# LOOP ######################
while ($point < 127100000) {
	$point++;
	print "$point  started\n";
	my $url = "$base$point";
	my $mech = WWW::Mechanize->new();
	if (eval {$mech->get($url)}) {
		$mech->save_content("$dump/$point");
		print "$point  ended\n";
	}
	else 
		{ print $lfh "$point fail\n"; next; }
# ACCOUNTING ################
	if ($point % 100 == 0) {
		open(my $fifh, '>', $init);
		print $fifh "$point\n"; close $fifh;
	}
}
# SUB ########################
sub pause { 
	my $pausefile = "NEO_PAUSE";
	open(my $pfh, '<', $pausefile) or die "no $pausefile";
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; sleep $timeout;
}
# USER AGENT ################
sub uagent {
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2", 
		from => 'punxnotdead@wikiark.org',
		timeout => 45,
	);
	return $s_ua;
}
