#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
use HTTP::Cookies;
use File::Find::Rule;
###########################################
# ARKI - scrape archive.org pdfs ##########
###########################################
my ($target, $dump) = @ARGV;
die "not a target dir" unless -d $target;
die "not a dump dir" unless -d $dump;
my $file = 'tmp';
my $base = "http://archive.org/download";
# DAEMONIZE ##############################
$daemon = Proc::Daemon->new(
    work_dir     => '/MINION/ARKI',
    child_STDOUT => '/MINION/ARKI/ARKI_log',
    child_STDERR => '+>>/MINION/ARKI/ARKI_debug',
    pid_file     => '/MINION/ARKI/pid',
    exec_command => 'perl /MINION/ARKI/ARKI.pl',
);
# USER AGENT #############################
my $ua = LWP::UserAgent->new();
my $cookies = HTTP::Cookies->new(
	file=>"$dump/cookies.txt",
	autosave => 1,
);
$ua->cookie_jar($cookies);
$ua->agent("Windows IE 7");
$ua->timeout(60);
# BATCH PROC #############################
my $rule = File::Find::Rule->file()->start($target);
while (defined(my $file = $rule->match)){
	open(my $ifh, '<', $file) or die "Couldn't read $file\n";
	my @list = readline $ifh; chomp @list;
	foreach my $i (@list) {
# PAUSE ##################################
		if (-e "/tmp/PGET_PAUSE")
			{ pause; }
		print $lfh "$i  started\n"; # LOG #########
		my $url = "$base/$i/$i.pdf";7
		my $response = $ua->get($url, ':content_file'=>"$dump/$i");
    my $url = "$base/$i/$i.pdf";7
		my $response = $ua->get($url, ':content_file'=>"$dump/$i");
    my $murl = "$base"/"$i"_meta.xml;
    my $mresponse = $ua->get($url, ':content_file'=>"$dump"/"$i"_meta.xml);
		print "$i  ended\n";
	}
	close $ifh;
	unlink $file or die "Cant delete after use: $file";
} 
# SUB ###################################
sub pause 
	{ sleep(8000); }	
