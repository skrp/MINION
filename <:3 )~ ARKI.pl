#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
use MKRX::XS;
################################
# ARKI - scrape archive.org pdfs
#       <:3 )~   ---skrp of MKRX
my $target = '/MINION/ARKI/ARKI_QUEUE'; my $dump = 'MINION/ARKI/ARKI_dump';
my $pool = '/MINION/ARKI/ARKI_pool'; my $g '/MINION/ARKI/ARKI_g';
my $init = '/MINION/ARKI/ARKI_init';
die "not a $target" unless -e $target; die "not a target dir" unless -d $dump;
die "not a pool dir" unless -d $pool; die "not a g dir" unless -d $g;
my $base = "http://archive.org/download";
# DAEMONIZE #####################
$daemon = Proc::Daemon->new(
	work_dir     => '/MINION/ARKI',
	child_STDOUT => 'ARKI_LOG',
	child_STDERR => '+>>ARKI_DEBUG',
	pid_file     => 'ARKI_PID',
);
$daemon->Init();
# USER AGENT ####################
my $ua = uagent();
# BATCH PROC ###################
while (1) {
unless (-e "ARKI_QUEUE")
	{ sleep 60; }
open(my $ifh, '<', $target) or die "Couldn't read $target\n";
open(my $intfh, '<', $init) or die "Couldn't read $target\n";
my @list = readline $ifh; chomp @list;
unlink $target;
my $count = 0;
foreach my $i (@list) {
# PAUSE #######################
	if (-e "ARKI_pause")
		{ pause(); }
	print "$i  started\n";
	my $url = "$base/$i/$i.pdf";
	my $response = $ua->get($url, ':content_file'=>"$dump/$i");
   	my $murl = "$base/$i'_meta.xml'";
    	my $mresponse = $ua->get($url, ':content_file'=>"$dump/$i'_meta.xml'");
	my $XS_staus = `XS $dump $pool $g` or die "cant XS $i";
	print "$i  ended\n"; $count++;
	if ($count % 10 == 0) {
		open(my $initfh, '>', $init);
        foreach (@list)
		    print $initfh "$_\n";
		close $initfh;
	}
}
close $ifh;
unlink $target or die "Cant delete after use: $target";
}
# SUB ########################
sub pause {
	my $pausefile = "ARKI_pause";
	open(my $pfh, '<', $pausefile) or die "no $pausefile";
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; sleep $timeout;
}
sub uagent {
	LWP::UserAgent->new(
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2",
		from => 'punknotdead@wikiark.org',
		timeout => 45,
	);
	return $s_ua;
}
