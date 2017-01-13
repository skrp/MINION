#!/usr/local/bin/perl
use strict; use warnings;
use LWP::UserAgent;
use HTTP::Cookies;
use File::Find::Rule;
########################################
# NEO - scrape searchcode.com
# --------------------------skrp of MKRX
# USER AGENT ###########################
my ($dump) = @ARGV;
die "not a dump dir" unless -d $dump;
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 1 });
my $cookies = HTTP::Cookies->new(
	file=>"$dump/cookies.txt",
	autosave => 1,
);
$ua->cookie_jar($cookies);
$ua->agent("Windows IE 7");
$ua->timeout(60);
# SET UP ##############################
my $res = $ua->get("https://searchcode.com");
my $base = "https://searchcode.com/codesearch/raw/";
my $init = "init";
open(my $ifh, '<', $init) or die "Couldn't read $init\n";
my $point = readline $ifh; chomp $point; close $ifh;
# LOOP ################################
while ($point < 127100000) {
	$point++;
	print "$point  started\n";
	my $url = "$base$point/";
	my $response = $ua->get($url, ':content_file'=>"$dump/$point") or die "cant get $point";
	print "$point  ended\n";
	open(my $fifh, '>', $init) or die "Couldn't read $init\n";
	print $fifh "$point\n"; close $fifh;
}

