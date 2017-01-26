#!/usr/bin/perl
use strict; use warnings;
use LWP;
use WWW::Mechanize;
# use WWW::Mechanize::PhantomJS
# use WWW::Mechanize::Firefox
############################
# GOOG - imgur viral scraper
#    `o_0    ---skrp of MKRX
my $num = 0; # scrape top 60 images from today to Jan 2011
my $log = 'GOOG_LOG';
open(my $lfh, '>>', $log);
while ($num < 2218) { # farthest back is 2218 days
my $o_url = 'http://imgur.com/gallery/hot/viral/page/';
my $url = "$o_url$num";
print "$lfh" "$url: page\n";
my $temp = 'temp';
my $mech = WWW::Mechanize->new();
my $response = $mech->get($url);
$mech->save_content($temp);
# FILTER #########################3
open(my $tfh, '<', $temp);
my @content = readline $tfh; chomp @content; close $fh; unlink $temp;
my $pre_base = '<img alt="" src="//i.imgur.com/';
my $end = 'b.jpg" />';
foreach my $i (@content) {
        if ($i =~ /$pre_base/) {
                $i =~ s/$pre_base//;
                $i =~ s/$end//; $i =~ s/^\s+//;
                my $item = "$i.jpg";
                print "$lfh" "$item: item\n";
                my $here = "dump/$item";
                print "starting: $item\n";
                my $i_url = 'http://i.imgur.com/';
                $n_url = "$i_url$item";
                my $imech = WWW::Mechanize->new();
                my $response = $imech->get($n_url);
                $imech->save_content($here);
                print "$item: finished\n";
        }
}
sub uagent {
        my $s_ua = LWP::UserAgent->new(
                agent => "Mozilla/50.0.2",
                from => 'punxnotdead@wikiark.org',
                timeout => 45,
        );
        return $s_ua;
}
