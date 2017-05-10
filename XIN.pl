#!/usr/local/bin/perl
use strict; use warnings;
use LWP::UserAgent;
# missing computer
my $base = 'https://arxiv.org/';
my $showbase = '?show=';
open($Ufh, '>>', 'url_file');
my @list = (
    'stat',
    'q-fin',
    'q-bio',
    'math',
    'quant-ph',
    'physics',
    'nucl-th',
    'nucl-ex',
    'nlin',
    'math-ph',
    'hep-th',
    'hep-ph',
    'hep-lat',
    'hep-ex',
    'gr-qc',
    'cond-mat',
    'astro-ph'
);
foreach my $ilist (@list)
{
    my $y = 0;
    while ($y < 18)
    {
        my $im = 1;
        while ($im < 13)
        {
            my $dy = sprintf("%02d", $y);
            my $dim = sprintf("%02d", $im);
            my $itag = $dy.$dim;
            my $url = $base."list/$ilist/".$itag;
            my $num = get_num($url);
            next if ($num < 1);
            my $final_list = "$url.$showbase.$num";
            print $Ufh "$final_list\n";
            $im++;
        }
        $y++;
    }
    $y = 90;
    while ($y < 100)
    {
        my $im = 1;
        while ($im < 13)
        {
            my $dy = sprintf("%02d", $y);
            my $dim = sprintf("%02d", $im);
            my $itag = $dy.$dim;
            my $url = $base."list/$ilist/".$itag;
            my $num = get_num($url);
            next if ($num < 1);
            my $final_list = "$url.$showbase.$num";
            rint $Ufh "$final_list\n";
            $im++;
        }
        $y++;
    }
}
# SUB ###############################
sub uagent()
{
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2",
		timeout => 45,
	);
	return $s_ua;
}
sub get_num
{
    my ($url) = shift;
    my $ua = uagent();
    my $req = $ua->get($url, ':content_file'=>'tmp.html');
    my $btag1 = '<h2>No listing '; my $btag2 = '<p>Sadly, the requested ';
    my $numtag1 = '<small>[ total of '; my $numtag2 = ' entries:  <b>';
    open(my$Tfh, '<', 'tmp.html');
    my @content = readline $Tfh; chomp @content;
    my $number;
    foreach (@content) # url bad
        { if ((/\Q$btag1\E/) and (/\Q$btag2\E/)) { return 0; } }
    foreach (@content) # url pass
        { if (/\Q$numtag1\E/) { $number = $_; } }
    $number =~ s/.*\Q$numtag1\E//; $number =~ s/\Q$numtag2\E.*//;
    chomp $number; return $number;
}
