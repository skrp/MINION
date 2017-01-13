#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
use WWW::Mechanize;
use HTTP::Cookies;
use MKRX::XS;
#################################
# RUSKY - scrape golibgen.io pdfs
#     (__!__)     ---skrp of MKRX
# DAEMONIZE #####################
$daemon = Proc::Daemon->new(
    work_dir     => '/MINION/RUSKY',
    child_STDOUT => 'RUSKY_log',
    child_STDERR => '+>>RUSKY_debug',
    pid_file     => 'RUSKY_pid',
    exec_command => 'perl RUSKY.pl',
);
# SETUP #########################
my $base = "http://golibgen.io/view.php?id=";
my $dump = "RUSKY_dump";
my $pool = "RUSKY_pool";
my $g = "RUSKY_g";
my $inital = "RUSKY_init";
# INITIALIZE ####################
open(my $ifh, '<', $inital) or die "cant open $inital";
my $ttl = readline $ifh; chomp $ttl; close $ifh;
# USER AGENT ####################
my $ua = LWP::UserAgent->new();
my $cookies = HTTP::Cookies->new(
	file => "cookies.txt",
	autosave => 1,
);
$ua->cookie_jar($cookies);
$ua->agent("Windows IE 7");
# MECH ##########################
while ($ttl > 0) {
	my $iter = $ttl;
	my $mech = WWW::Mechanize->new($ua);
	my $url = $base.$iter;
	print "scraping $url\n";
	$mech->get($url);
	$mech->click('submit');
	$mech->save_content("$dump/$iter");
	XS($dump $pool $g) or die "can't XS $dump/$iter";
	$ttl--;
	open(my $finfh, '>', $initial) or die "can't reopen $initial";
	print $finfh "$ttl\n";
	print "stored $url\n";
	close $finfh;
}
