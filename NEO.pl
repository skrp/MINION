#!/usr/local/bin/perl
use strict; use warnings; $|=1; $0='NEO';
use File::Find::Rule;
use WWW::Mechanize;
use Proc::Daemon;
use LWP::UserAgent;
use LWP::Protocols::https;
################### SUMMONS #
# NEO - scrape searchcode.com
#   (<>..<>)  ---skry of MKRX
# SETUP ###############################
my $work = 'MINION/' my $dump = 'dump';
my $state = 'STATE'; my $debug = 'DEBUG';
my $log = 'LOG'; my $pid = 'PID';
my $que = 'QUE'; my $clean = 'CLEAN'
my $pause = 'PAUSE'; my $shutdown = 'SHUT';
# DAEMONIZE ##########################
my $daemon = Proc::Daemon->new(
    work_dir     => $work,
    child_STDOUT => $log,
    child_STDERR => +>>$debug,
    pid_file     => $pid,
);
$daemon->Init();
# USER AGENT ###############
my $ua = uagent();
# PROC ###################
open(my $ifh, '<', $init) or die "Couldn't read $init\n";
my $point = readline $ifh; chomp $point; close $ifh;
while ($point < 127100000) {
	sleep 1;
	if (-e "NEO_SHUTDOWN")
		{ shut(); }
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
sub shut {
	my $shut = "NEO_SHUTDOWN";
	unlink $shut;
	open(my $sinitfh, '>', $init);
	foreach (@list)
		{ print $sinitfh "$_\n"; }
	die "Shutdown CLEAN";
}
sub uagent {
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2", 
		from => 'punxnotdead@wikiark.org',
		timeout => 45,
	);
	return $s_ua;
}
