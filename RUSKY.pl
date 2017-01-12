#!/usr/local/bin/perl
use strict; use warnings;
# scrape http://golibgen.io
use LWP::UserAgent;
use WWW::Mechanize;
use HTTP::Cookies;

my $ua = LWP::UserAgent->new();
my $cookies = HTTP::Cookies->new(
	file => "cookies.txt",
	autosave => 1,
);
$ua->cookie_jar($cookies);
$ua->agent("Windows IE 7");

my $base = "http://golibgen.io/view.php?id=";
my $mech = WWW::Mechanize->new($ua);
my $tst = 23;
my $url = $base.$tst;
print "$url\n";
$mech->get($url);
$mech->click('submit');
$mech->save_content("23");
