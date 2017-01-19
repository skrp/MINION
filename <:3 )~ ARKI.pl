#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
################################
# ARKI - scrape archive.org pdfs 
#       <:3 )~   ---skrp of MKRX
# SETUP ########################
my $init = '/OPN/MINION/ARKI/ARKI_QUE'; 
my $dump = '/OPN/MINION/ARKI/ARKI_dump';
my $pool = '/OPN/MINION/ARKI/ARKI_pool'; 
my $g = '/OPN/MINION/ARKI/ARKI_g';
die "no $init" unless -e $init;
die "not a pool dir" unless -d $pool; 
die "not a g dir" unless -d $g;
my $base = "http://archive.org/download";
# DAEMONIZE #####################
my $daemon = Proc::Daemon->new(
    work_dir     => '/OPN/MINION/ARKI',
    child_STDOUT => 'ARKI_LOG',
    child_STDERR => '+>>ARKI_DEBUG',
    pid_file     => 'ARKI_PID',
);
$daemon->Init(); # or die "no pid of init";
# USER AGENT ####################
my $ua = uagent();
# PROC ###################
unless (-e $init) { sleep 60; }
open(my $initfh, '<', $init) or die "Couldn't read $init\n";
my @list = readline $initfh; chomp @list;
close $initfh; unlink $init;
my $count = 0;
foreach my $i (@list) {
		if (-e "ARKI_PAUSE")
			{ pause(); }
		print "$i  started\n";
		my $url = "$base/$i/$i.pdf";
		my $response = $ua->get($url, ':content_file'=>"$dump/$i");
  		my $murl = "$base/$i".'_meta.xml';
   	my $mresponse = $ua->get($url, ':content_file'=>"$dump/$i".'_meta.xml');
#		my $XS_status = `XS $dump $pool $g` or die "Can't XS";
		print "$i  ended\n";
		if ($count % 20 == 0) {
			open(my $finitfh, '>', $init);
			foreach (@list)
				{ print $finitfh "$_\n"; }
			close $finitfh;
		}
}
# SUB ########################
sub pause { 
	my $pausefile = "ARKI_PAUSE";
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

