#!/usr/local/bin/perl
use strict; use warnings; $|=1; $0='ARK';
use Proc::Daemon;
use LWP::UserAgent;
###################### SUMMONS #
# ARKI - scrape archive.org pdfs 
#       <:3 )~   ---skrp of MKRX
# SETUP ########################
my $target = 'ARKI_QUE'; 
my $dump = 'ARKI_dump';
my $shutdown = 'ARKI_SHUTDOWN';
my $init = 'ARKI_INIT';
my $base = "http://archive.org/download";
# DAEMONIZE #####################
my $daemon = Proc::Daemon->new(
    work_dir     => 'MINION/ARKI',
    child_STDOUT => '+>>ARKI_LOG',
    child_STDERR => '+>>ARKI_DEBUG',
    pid_file     => 'ARKI_PID',
);
$daemon->Init();
# USER AGENT ####################
my $ua = uagent();
# PROC ###################
unless (-e $target) { sleep 3600; }
open(my $tfh, '<', $target) or die "Couldn't read $target\n";
my @list = readline $tfh; chomp @list;
close $tfh; unlink $target;
my $count = 0;
foreach my $i (@list) {
	sleep 1;
	if (-e "ARKI_SHUTDOWN")
		{ shut(); }
	if (-e "ARKI_PAUSE")
		{ pause(); }
	print "$i  started\n";
	my $url = "$base/$i/$i.pdf";
	my $response = $ua->get($url, ':content_file'=>"$dump/$i");
  	my $murl = "$base/$i".'_meta.xml';
   	my $mresponse = $ua->get($url, ':content_file'=>"$dump/$i".'_meta.xml');
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
	my $pausefile = "ARKI_PAUSE";
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