#!/usr/local/bin/perl
use strict; use warnings;
use LWP::UserAgent;
use LWP::Protocol::https;
# missing computer section
#my $prox =':8080';
my $dump = 'dump';
my $base = 'https://arxiv.org/';
my $showbase = '?show=';
open(my $nfh, '<', 'numbers');
my @list = readline $nfh;
foreach my $ilist (@list)
{
    sleep 1;
    my @t = split(/ /, $ilist);
    my $url = "https://$t[0]?show=$t[1]\n";
    my $ua = uagent();
#   $ua->proxy('http', "http://$prox");
    print "workn $url\n";
    my $file = $t[0]; $file =~ s/\//_/g;
    my $res = $ua->get($url, ':content_file'=>"$dump/$file");
    print "$dump/$file\n";
    if (-f "$dump/$file")
        { print "success\n"; }
    else
        { die "blocked\n"; }
}
# SUB ###############################
sub uagent
{
    my $s_ua = LWP::UserAgent->new(
        agent => "Mozilla/50.0.2",
        timeout => 45,
    );
    return $s_ua;
}
