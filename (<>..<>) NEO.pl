#!/usr/local/bin/perl
use strict; use warnings; $|=1; $0='NEO';
use File::Find::Rule;
use WWW::Mechanize;
use Proc::Daemon;
use LWP::UserAgent;
#############################
# NEO - scrape searchcode.com
#   (<>..<>)  ---skry of MKRX
# SETUP #####################
my $target = 'NEO_QUE'; 
my $dump = 'NEO_dump';
my $pool = 'NEO_pool'; 
my $g = 'NEO_g';
my $init = 'NEO_INIT';
my $base = "https://searchcode.com/codesearch/raw/";
# DAEMONIZE ################
my $daemon = Proc::Daemon->new();
    work_dir     => 'MINION/NEO',
    child_STDOUT => 'NEO_LOG',
    child_STDERR => '+>>NEO_DEBUG',
    pid_file     => 'NEO_PID',
);
$daemon->Init();
# USER AGENT ###############
my $ua = uagent();
# PROC ###################
open(my $ifh, '<', $init) or die "Couldn't read $init\n";
my $point = readline $ifh; chomp $point; close $ifh;
while ($point < 127100000) {
	sleep 1;
	if (-e "NEO_PAUSE")
		{ pause(); }
	$point++;
	print "$point  started\n";
	my $url = "$base$point";
	my $mech = WWW::Mechanize->new();
	if (eval {$mech->get($url)}) {
		$mech->save_content("$dump/$point");
		print "$point  ended\n";
	}
	else 
		{ print "$point fail\n"; next; }
# ACCOUNTING ###############
	if ($point % 100 == 0) {
		open(my $fifh, '<', $init) or die "Couldn't read $init\n";
		print $fifh "$point\n"; close $fifh;
	}
}
# SUB ######################
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
