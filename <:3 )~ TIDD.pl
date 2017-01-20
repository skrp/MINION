#!/usr/local/bin/perl
use strict; use warnings; $|=1; $0='TIDD';
use Proc::Daemon;
use LWP::UserAgent;
################################
# ARKI - scrape archive.org pdfs 
#       <:3 )~   ---skrp of MKRX
# SETUP ########################
my $target = 'TIDD_QUE'; 
my $dump = 'TIDD_dump';
my $pool = 'TIDD_pool'; 
my $g = 'TIDD_g';
my $init = 'TIDD_INIT';
my $shutdown = 'TIDD_SHUTDOWN';
my $base = "http://archive.org/compress";
# DAEMONIZE #####################
my $daemon = Proc::Daemon->new(
    work_dir     => '/OPN/MINION/TIDD',
    child_STDOUT => 'TIDD_LOG',
    child_STDERR => '+>>TIDD_DEBUG',
    pid_file     => 'TIDD_PID',
);
$daemon->Init(); 
# USER AGENT ####################
my $ua = uagent();
# PROC ###################
unless (-e $init) { sleep 60; }
open(my $tfh, '<', $target) or die "Couldn't read $target\n";
my @list = readline $tfh; chomp @list;
close $tfh; unlink $target;
my $count = 0;
foreach my $i (@list) {
		sleep 1;
		if (-e "ARKI_SHUTDOWN")
			{ shut(); }
		if (-e "TIDD_PAUSE")
			{ pause(); }
		print "$i  started\n";
		my $url = "$base/$i";
		my $response = $ua->get($url, ':content_file'=>"$dump/$i");
		print "$i  ended\n";
		shift @list; $count++;
		if ($count % 20 == 0) {
			open(my $finitfh, '>', $init);
			foreach (@list)
				{ print $finitfh "$_\n"; }
			close $finitfh;
		}
}
unlink $init;
# SUB ########################
sub pause { 
	my $pausefile = "TIDD_PAUSE";
	open(my $pfh, '<', $pausefile) or die "no $pausefile";
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; sleep $timeout;
}
sub shut {
	my $shut = "ARKI_SHUTDOWN";
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

