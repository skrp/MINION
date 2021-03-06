#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP;
use WWW::Mechanize;
################## SUMMONS #
# GOOG - imgur viral scraper
#    `o_0    ---skrp of MKRX
# SETUP ###############################
my $work = 'MINION/';
my $limbo = 'limbo'; my $dump = 'dump';
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
# PROC #####################

my $num = 164; # scrape top 60 images from today to Jan 2011
while ($num < 2218) { # farthest back is 2218 days
	my $o_url = 'http://imgur.com/gallery/hot/viral/page/';
	my $url = "$o_url$num";
	open(my $ifh, '>>', $init);
	print $ifh "$url: page\n";
	my $temp = 'temp';
	my $ua = uagent();
	my $mech = WWW::Mechanize->new($ua);
	my $response = $mech->get($url);
	$mech->save_content($temp);
# FILTER #########################
	open(my $tfh, '<', $temp);
	my @content = readline $tfh; chomp @content; close $tfh; unlink $temp;
	my $pre_base = '<img alt="" src="//i.imgur.com/';
	my $end = 'b.jpg" />';
	foreach my $i (@content) {
   	     if ($i =~ /$pre_base/) {
					$i =~ s/$pre_base//;
         	 	$i =~ s/$end//; $i =~ s/^\s+//;
         		my $item = "$i.jpg";
           		print "$item: item\n";
           		my $here = "$dump/$item";
             	print "starting: $item\n";
					my $vua = uagent();
             	my $i_url = 'http://i.imgur.com/';
              	my $n_url = "$i_url$item";
              	my $imech = WWW::Mechanize->new($vua);
               my $response = $imech->get($n_url);
               $imech->save_content($here);
               print "$item: finished\n";
        		}
	}
	$num++;
}
# SUB ##########################
sub pause {
	my $pausefile = 'GOOG_PAUSE';
	open(my $pfh, '<', $pausefile);
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; 
	sleep $timeout;
}
sub shut {
	my $shut = 'GOOG_SHUTDOWN';
	unlink $shut;
	open(my $sinitfh, '>', $init);
#	foreach (@content)
#		{ print $sinitfh "$_\n"; }
	die "Shutdown clean\n";
}
sub uagent {
	my $s_ua = LWP::UserAgent->new(
	agent => "Mozilla/50.0.2",
	from => 'punxnotdead@wikiark.org',
	timeout => 45,
	);
	return $s_ua;
}
