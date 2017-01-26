#!/usr/bin/perl
use LWP;
use WWW::Mechanize;
my $num = 162;
my $log = 'GOOG_LOG';
open(my $lfh, '>>', $log);
while ($num < 2218) {
my $o_url = 'http://imgur.com/gallery/hot/viral/page/';
my $url = "$o_url$num";
print "$lfh" "$num : $url\n";
my $temp = 'temp';
my $mech = WWW::Mechanize->new();
my $response = $mech->get($url);
$mech->save_content($temp);

# FILTER #########################3
print "filter time\n";
open(my $tfh, '<', $temp) or die "fkn encoding";
my @content = readline $tfh; chomp @content; close $fh; unlink $temp;
my $pre_base = '<img alt="" src="//i.imgur.com/';
my $end = 'b.jpg" />';
print "start time\n";
foreach my $i (@content) {
        if ($i =~ /$pre_base/) {
                $i =~ s/$pre_base//;
                $i =~ s/$end//; $i =~ s/^\s+//;
                my $item = "$i.jpg";
#               print "$item\n";
                my $here = "dump/$item";
                print "starting: $item\n";
                my $i_url = 'http://i.imgur.com/';
                $n_url = "$i_url$item";
        #       print "$n_url\n";
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
$num++;
}
