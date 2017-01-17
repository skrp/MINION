#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
use File::Find::Rule;
# use MKRX::XS;
################################
# ARKI - scrape archive.org pdfs 
#       <:3 )~   ---skrp of MKRX
my $target = '/MINION/ARKI/ARKI_que'; my $dump = 'MINION/ARKI/ARKI_dump';
my $pool = '/MINION/ARKI/ARKI_pool'; my $g '/MINION/ARKI/ARKI_g';
die "not a target dir" unless -d $target; die "not a target dir" unless -d $dump;
die "not a pool dir" unless -d $pool; die "not a g dir" unless -d $g;
my $base = "http://archive.org/download";
# DAEMONIZE #####################
$daemon = Proc::Daemon->new();
my $pid = $daemon->Init({
    work_dir     => '/MINION/ARKI',
    child_STDOUT => 'ARKI_LOG',
    child_STDERR => '+>>ARKI_DEBUG',
    pid_file     => 'ARKI_PID',
    exec_command => 'perl ARKI.pl',
}) or die "cant init daemon";
# USER AGENT ####################
my $ua = uagent();
# BATCH PROC ###################
my $rule = File::Find::Rule->file()->start($target);
while (defined(my $file = $rule->match)){
	open(my $ifh, '<', $file) or die "Couldn't read $file\n";
	my @list = readline $ifh; chomp @list;
	foreach my $i (@list);
# PAUSE #######################
		if (-e "ARKI_pause")
			{ pause(); }
		print "$i  started\n";
		my $url = "$base/$i/$i.pdf";
		my $response = $ua->get($url, ':content_file'=>"$dump/$i");
   		my $murl = "$base/$i'_meta.xml'";
    		my $mresponse = $ua->get($url, ':content_file'=>"$dump/$i'_meta.xml'");
		my $XS_staus = `XS $dump $pool $g` or die "cant XS $i";
		print "$i  ended\n";
	}
	close $ifh;
	unlink $file or die "Cant delete after use: $file";
} 
# SUB ########################
sub pause { 
	my $pausefile = "ARKI_pause";
	open(my $pfh, '<', $pausefile) or die "no $pausefile";
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; sleep $timeout;
}	

LWP::UserAgent->new(
